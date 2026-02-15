import { Browser, chromium, firefox, webkit, LaunchOptions } from 'playwright';

export type BrowserType = 'chromium' | 'firefox' | 'webkit' | 'msedge';

export class BrowserFactory {
  private static readonly validBrowsers: BrowserType[] = ['chromium', 'firefox', 'webkit', 'msedge'];

  static validate(browserType: string): void {
    if (!this.validBrowsers.includes(browserType as BrowserType)) {
      throw new Error(`Invalid browser: ${browserType}. Valid options: ${this.validBrowsers.join(', ')}`);
    }
  }

  static async create(browserType: BrowserType, options: LaunchOptions): Promise<Browser> {
    this.validate(browserType);

    switch (browserType) {
      case 'firefox':
        return await firefox.launch(options);
      case 'webkit':
        return await webkit.launch(options);
      case 'msedge':
        return await chromium.launch({ ...options, channel: 'msedge' });
      default:
        return await chromium.launch(options);
    }
  }
}
