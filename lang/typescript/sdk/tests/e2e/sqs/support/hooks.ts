import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { SQSClient } from "@aws-sdk/client-sqs";
import { LwsSession } from "../../../../src/index.js";
import type { SqsWorld } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedSqsClient: SQSClient | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession();
  await sharedSession.start();
  sharedSqsClient = new SQSClient(sharedSession.clientConfig("sqs"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedSqsClient = null;
});

Before(async function (this: SqsWorld) {
  if (sharedSession === null || sharedSqsClient === null) {
    throw new Error("Session not initialized");
  }
  this.session = sharedSession;
  this.sqsClient = sharedSqsClient;
  this.error = null;
  this.result = null;
  this.receiptHandle = null;
  this.messageId = null;
  await this.session.reset();
});

After(async function (this: SqsWorld) {
  this.error = null;
  this.result = null;
  this.receiptHandle = null;
  this.messageId = null;
});
