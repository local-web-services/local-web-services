import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { SNSClient } from "@aws-sdk/client-sns";
import { LwsSession } from "../../../../src/index.js";

export const TEST_TOPIC_NAME = "lws-e2e-test-topic";

export interface SnsWorld extends CucumberWorld {
  session: LwsSession;
  snsClient: SNSClient;
  topicArn: string;
  error: Error | null;
  result: unknown;
}

class SnsWorldImpl extends CucumberWorld implements SnsWorld {
  declare session: LwsSession;
  declare snsClient: SNSClient;
  topicArn: string = "";
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(SnsWorldImpl);
