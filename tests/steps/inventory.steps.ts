import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';

When('I add {string} to the cart', async function (this: CustomWorld, productName: string) {
  await this.inventoryPage.addProductToCart(productName);
});

When('I go to the cart', async function (this: CustomWorld) {
  await this.inventoryPage.goToCart();
});

Then('the cart badge should show {int} item', async function (this: CustomWorld, expectedCount: number) {
  await this.inventoryPage.verifyCartBadgeCount(expectedCount);
});
