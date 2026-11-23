import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { SecretsManagerClient } from "@aws-sdk/client-secrets-manager";
import { LwsSession } from "../../../../src/index.js";
import type { SecretsWorld } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedSecretsClient: SecretsManagerClient | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession();
  await sharedSession.start();
  sharedSecretsClient = new SecretsManagerClient(sharedSession.clientConfig("secretsmanager"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedSecretsClient = null;
});

Before(async function (this: SecretsWorld) {
  if (sharedSession === null || sharedSecretsClient === null) {
    throw new Error("Secrets session not initialized");
  }
  this.session = sharedSession;
  this.secretsClient = sharedSecretsClient;
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: SecretsWorld) {
  this.error = null;
  this.result = null;
});
