import { Given } from "@cucumber/cucumber";
import { OrderWorld } from "../support/world";

Given(
  "IAM is in enforce mode with identity {string} allowed all actions on all resources",
  async function (this: OrderWorld, identityName: string) {
    await this.session!.iam.identity(identityName)
      .allow(["*"], "*")
      .apply()
      .mode("enforce")
      .defaultIdentity(identityName)
      .apply();
  },
);
