import { Given } from "@cucumber/cucumber";
import { OrderWorld } from "../support/world";

Given("stepfunctions chaos is set to 100% error rate", async function (this: OrderWorld) {
  await this.session!.chaos("stepfunctions").errorRate(1.0).apply();
});
