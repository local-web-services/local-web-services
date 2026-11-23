import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { SQSClient } from "@aws-sdk/client-sqs";
import { LwsSession } from "../../../../src/index.js";

export const TEST_QUEUE = "lws-e2e-test-queue";
export const TEST_MESSAGE = "lws-e2e-test-message";

export interface SqsWorld extends CucumberWorld {
  session: LwsSession;
  sqsClient: SQSClient;
  error: Error | null;
  result: unknown;
  receiptHandle: string | null;
  messageId: string | null;
}

class SqsWorldImpl extends CucumberWorld implements SqsWorld {
  declare session: LwsSession;
  declare sqsClient: SQSClient;
  error: Error | null = null;
  result: unknown = null;
  receiptHandle: string | null = null;
  messageId: string | null = null;
}

setWorldConstructor(SqsWorldImpl);
