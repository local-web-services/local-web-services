import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { LambdaClient } from "@aws-sdk/client-lambda";
import { makeSession } from "./world.js";
import type { LambdaWorld } from "./world.js";

let sharedSession = makeSession();
let sharedLambdaClient: LambdaClient | null = null;

BeforeAll(async function () {
  await sharedSession.start();
  sharedLambdaClient = new LambdaClient(sharedSession.clientConfig("lambda"));
});

AfterAll(async function () {
  await sharedSession.stop();
});

Before(async function (this: LambdaWorld) {
  if (sharedLambdaClient === null) throw new Error("Lambda session not initialized");
  this.session = sharedSession;
  this.lambdaClient = sharedLambdaClient;
  this.functionArn = "";
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: LambdaWorld) {
  this.error = null;
  this.result = null;
});
