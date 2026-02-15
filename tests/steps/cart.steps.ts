import { When } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';

When('I proceed to checkout', async function (this: CustomWorld) {
  await this.cartPage.proceedToCheckout();
});
