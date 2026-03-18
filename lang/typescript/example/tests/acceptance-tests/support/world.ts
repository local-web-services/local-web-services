import { setWorldConstructor, World, Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import {
  LwsSession,
  DynamoDBHelper,
  SQSHelper,
  FakeBuilder,
  LogCapture,
} from "local-web-services-typescript-sdk";
import { SFNClient } from "@aws-sdk/client-sfn";

let sharedSession: LwsSession;

BeforeAll(async function () {
  sharedSession = await LwsSession.start();
});

AfterAll(async function () {
  await sharedSession.close();
});

export class OrderWorld extends World {
  session: LwsSession | null = null;
  sfnClient: SFNClient | null = null;
  stateMachineArn: string = "";
  lastOutput: Record<string, unknown> | null = null;
  lastError: Error | null = null;
  logCapture: LogCapture | null = null;
  sfnFakeBuilder: FakeBuilder | null = null;
  fakeExecutionArn: string = "";
  processedOutputs: Record<string, unknown>[] = [];
  processedIDs: string[] = [];
  ddbHelper: DynamoDBHelper | null = null;
  sqsHelper: SQSHelper | null = null;
}

Before(async function (this: OrderWorld) {
  this.session = sharedSession;
  await this.session.reset();
  this.sfnClient = null;
  this.stateMachineArn = "";
  this.lastOutput = null;
  this.lastError = null;
  this.logCapture = null;
  this.sfnFakeBuilder = null;
  this.fakeExecutionArn = "";
  this.processedOutputs = [];
  this.processedIDs = [];
  this.ddbHelper = null;
  this.sqsHelper = null;
});

After(async function (this: OrderWorld) {
  if (this.logCapture) {
    try {
      await this.logCapture.stop();
    } catch (_) {
      // ignore errors stopping log capture
    }
    this.logCapture = null;
  }
  // Close scenario-specific sessions (e.g., from HCL discovery)
  if (this.session && this.session !== sharedSession) {
    await this.session.close();
    this.session = sharedSession;
  }
});

setWorldConstructor(OrderWorld);
