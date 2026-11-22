import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { EventBridgeClient } from "@aws-sdk/client-eventbridge";
import { LwsSession, EventBus } from "../../../../src/index.js";

export const TEST_BUS = "lws-e2e-test-bus";
export const TEST_SOURCE = "test.source";
export const TEST_DETAIL_TYPE = "TestEvent";
export const TEST_RULE = "lws-e2e-test-rule";

export interface EventBridgeWorld extends CucumberWorld {
  session: LwsSession;
  ebClient: EventBridgeClient;
  busArn: string;
  error: Error | null;
  result: unknown;
}

class EventBridgeWorldImpl extends CucumberWorld implements EventBridgeWorld {
  declare session: LwsSession;
  declare ebClient: EventBridgeClient;
  busArn: string = "";
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(EventBridgeWorldImpl);

export function makeSession(): LwsSession {
  return new LwsSession();
}
