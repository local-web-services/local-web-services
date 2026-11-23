import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { SSMClient } from "@aws-sdk/client-ssm";
import { LwsSession, SsmParameter } from "../../../../src/index.js";
import type { SsmWorld } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedSsmClient: SSMClient | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession(new SsmParameter("/lws/e2e/seeded", "seeded-value"));
  await sharedSession.start();
  sharedSsmClient = new SSMClient(sharedSession.clientConfig("ssm"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedSsmClient = null;
});

Before(async function (this: SsmWorld) {
  if (sharedSession === null || sharedSsmClient === null) {
    throw new Error("SSM session not initialized");
  }
  this.session = sharedSession;
  this.ssmClient = sharedSsmClient;
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: SsmWorld) {
  this.error = null;
  this.result = null;
});
