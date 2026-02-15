import { Before, After, Status, setDefaultTimeout } from '@cucumber/cucumber';
import { CustomWorld } from './world';
import { mkdirSync, existsSync } from 'node:fs';
import { join, dirname } from 'node:path';

setDefaultTimeout(60000);

Before(async function (this: CustomWorld) {
  await this.init();
});

After(async function (this: CustomWorld, { result, pickle }) {
  const browserType = process.env.BROWSER || 'chromium';
  const sanitizedName = pickle.name
    .replaceAll(/[^a-zA-Z0-9]/g, '_')
    .substring(0, 50);
  
  if (result?.status === Status.FAILED && this.page) {
    const screenshotPath = join('reports', 'screenshots', browserType, `${sanitizedName}_${Date.now()}.png`);
    
    if (!existsSync(dirname(screenshotPath))) {
      mkdirSync(dirname(screenshotPath), { recursive: true });
    }
    
    await this.page.screenshot({ path: screenshotPath, fullPage: true });
    console.log(`Screenshot saved: ${screenshotPath}`);
  }
  
  await this.cleanup();
});
