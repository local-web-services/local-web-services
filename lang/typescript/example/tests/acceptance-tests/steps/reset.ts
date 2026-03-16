import { When, Then } from '@cucumber/cucumber';
import { OrderWorld } from '../support/world';

When('I reset the session', async function (this: OrderWorld) {
  await this.session!.reset();
});

Then('the session accepts a second reset without error', async function (this: OrderWorld) {
  await this.session!.reset();
});
