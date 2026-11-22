import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { EventBridgeClient } from "@aws-sdk/client-eventbridge";
import { makeSession } from "./world.js";
import type { EventBridgeWorld } from "./world.js";

let sharedSession = makeSession();
let sharedEbClient: EventBridgeClient | null = null;

BeforeAll(async function () {
  await sharedSession.start();
  sharedEbClient = new EventBridgeClient(sharedSession.clientConfig("events"));
});

AfterAll(async function () {
  await sharedSession.stop();
});

Before(async function (this: EventBridgeWorld) {
  if (sharedEbClient === null) throw new Error("EventBridge session not initialized");
  this.session = sharedSession;
  this.ebClient = sharedEbClient;
  this.busArn = "";
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: EventBridgeWorld) {
  this.error = null;
  this.result = null;
});
