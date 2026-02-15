import { Page, Locator, expect } from '@playwright/test';

export class InventoryPage {
  private readonly cartBadge: Locator;
  private readonly cartLink: Locator;

  constructor(private readonly page: Page) {
    this.cartBadge = page.locator('[data-test="shopping-cart-badge"]');
    this.cartLink = page.locator('[data-test="shopping-cart-link"]');
  }

  async addProductToCart(productName: string): Promise<void> {
    const productCard = this.page.locator('.inventory_item', { hasText: productName });
    await productCard.locator('[data-test^="add-to-cart"]').click();
  }

  async verifyCartBadgeCount(expectedCount: number): Promise<void> {
    await expect(this.cartBadge).toHaveText(expectedCount.toString());
  }

  async goToCart(): Promise<void> {
    await this.cartLink.click();
  }
}
