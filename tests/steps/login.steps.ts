import { Given, When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';

Given('I am on the SauceDemo login page', async function (this: CustomWorld) {
  await this.loginPage.navigate();
});

When('I login with username {string} and password {string}', async function (this: CustomWorld, username: string, password: string) {
  await this.loginPage.login(username, password);
});

Then('I should be redirected to the inventory page', async function (this: CustomWorld) {
  await this.loginPage.verifyOnInventoryPage();
});

Then('I should see the error message {string}', async function (this: CustomWorld, expectedError: string) {
  await this.loginPage.verifyErrorMessage(expectedError);
});
