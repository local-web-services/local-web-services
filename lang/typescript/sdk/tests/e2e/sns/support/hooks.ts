import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { SNSClient } from "@aws-sdk/client-sns";
import { LwsSession } from "../../../../src/index.js";
import type { SnsWorld } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedSnsClient: SNSClient | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession();
  await sharedSession.start();
  sharedSnsClient = new SNSClient(sharedSession.clientConfig("sns"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedSnsClient = null;
});

Before(async function (this: SnsWorld) {
  if (sharedSession === null || sharedSnsClient === null) {
    throw new Error("SNS session not initialized");
  }
  this.session = sharedSession;
  this.snsClient = sharedSnsClient;
  this.topicArn = "";
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: SnsWorld) {
  this.error = null;
  this.result = null;
});
