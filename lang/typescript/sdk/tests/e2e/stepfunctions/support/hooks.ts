import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { SFNClient } from "@aws-sdk/client-sfn";
import { makeSession } from "./world.js";
import type { StepFunctionsWorld } from "./world.js";

let sharedSession = makeSession();
let sharedSfnClient: SFNClient | null = null;

BeforeAll(async function () {
  await sharedSession.start();
  sharedSfnClient = new SFNClient(sharedSession.clientConfig("states"));
});

AfterAll(async function () {
  await sharedSession.stop();
});

Before(async function (this: StepFunctionsWorld) {
  if (sharedSfnClient === null) throw new Error("Step Functions session not initialized");
  this.session = sharedSession;
  this.sfnClient = sharedSfnClient;
  this.machineArn = "";
  this.executionArn = "";
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: StepFunctionsWorld) {
  this.error = null;
  this.result = null;
});
