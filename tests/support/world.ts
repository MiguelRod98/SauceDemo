import { setWorldConstructor, World, IWorldOptions } from '@cucumber/cucumber';
import { Browser, BrowserContext, Page } from 'playwright';
import { LoginPage } from '../pages/loginPage';
import { InventoryPage } from '../pages/inventoryPage';
import { CartPage } from '../pages/cartPage';
import { CheckoutPage } from '../pages/checkoutPage';
import { BrowserFactory, BrowserType } from './browserFactory';

export interface CustomWorld extends World {
  browser?: Browser;
  context?: BrowserContext;
  page?: Page;
  loginPage: LoginPage;
  inventoryPage: InventoryPage;
  cartPage: CartPage;
  checkoutPage: CheckoutPage;
  init(): Promise<void>;
  cleanup(): Promise<void>;
}

export class CustomWorldImpl extends World implements CustomWorld {
  browser?: Browser;
  context?: BrowserContext;
  page?: Page;
  loginPage!: LoginPage;
  inventoryPage!: InventoryPage;
  cartPage!: CartPage;
  checkoutPage!: CheckoutPage;

  constructor(options: IWorldOptions) {
    super(options);
  }

  private getTimestamp(): string {
    const now = new Date();
    return `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}T${String(now.getHours()).padStart(2, '0')}-${String(now.getMinutes()).padStart(2, '0')}-${String(now.getSeconds()).padStart(2, '0')}`;
  }

  async init(): Promise<void> {
    const browserType = (process.env.BROWSER || 'chromium') as BrowserType;
    const headless = process.env.HEADLESS === 'true' || process.env.CI === 'true';
    const timestamp = this.getTimestamp();
    
    this.browser = await BrowserFactory.create(browserType, { headless });
    
    this.context = await this.browser.newContext({
      baseURL: 'https://www.saucedemo.com',
      viewport: { width: 1920, height: 1080 },
      recordVideo: {
        dir: `./reports/videos/${browserType}/${timestamp}`,
        size: { width: 1920, height: 1080 }
      }
    });
    this.context.setDefaultTimeout(60000);
    this.context.setDefaultNavigationTimeout(60000);
    this.page = await this.context.newPage();
    this.loginPage = new LoginPage(this.page);
    this.inventoryPage = new InventoryPage(this.page);
    this.cartPage = new CartPage(this.page);
    this.checkoutPage = new CheckoutPage(this.page);
  }

  async cleanup(): Promise<void> {
    await this.context?.close();
    await this.browser?.close();
  }
}

setWorldConstructor(CustomWorldImpl);
