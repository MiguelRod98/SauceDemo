import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';

When('I fill checkout information with firstName {string}, lastName {string}, and postalCode {string}', async function (this: CustomWorld, firstName: string, lastName: string, postalCode: string) {
  await this.checkoutPage.fillInformation(firstName, lastName, postalCode);
});

When('I finish the checkout', async function (this: CustomWorld) {
  await this.checkoutPage.finishCheckout();
});

Then('I should see the confirmation message {string}', async function (this: CustomWorld, expectedMessage: string) {
  await this.checkoutPage.verifyConfirmationMessage(expectedMessage);
});
