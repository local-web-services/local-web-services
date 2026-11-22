import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { LwsSession, DynamoTable } from "../../../../src/index.js";
import type { DynamoWorld } from "./world.js";
import { TEST_TABLE } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedDynamoClient: DynamoDBClient | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession(new DynamoTable(TEST_TABLE, "pk"));
  await sharedSession.start();
  sharedDynamoClient = new DynamoDBClient(sharedSession.clientConfig("dynamodb"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedDynamoClient = null;
});

Before(async function (this: DynamoWorld) {
  if (sharedSession === null || sharedDynamoClient === null) {
    throw new Error("Session not initialized");
  }
  this.session = sharedSession;
  this.dynamoClient = sharedDynamoClient;
  this.error = null;
  this.result = null;
  this.item = null;
  await this.session.reset();
});

After(async function (this: DynamoWorld) {
  this.error = null;
  this.result = null;
  this.item = null;
});
