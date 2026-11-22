import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { SFNClient } from "@aws-sdk/client-sfn";
import { LwsSession, StateMachine } from "../../../../src/index.js";

export const TEST_MACHINE = "lws-e2e-test-machine";
export const SIMPLE_DEF = JSON.stringify({
  Comment: "test",
  StartAt: "Done",
  States: { Done: { Type: "Succeed" } },
});

export interface StepFunctionsWorld extends CucumberWorld {
  session: LwsSession;
  sfnClient: SFNClient;
  machineArn: string;
  executionArn: string;
  error: Error | null;
  result: unknown;
}

class StepFunctionsWorldImpl extends CucumberWorld implements StepFunctionsWorld {
  declare session: LwsSession;
  declare sfnClient: SFNClient;
  machineArn: string = "";
  executionArn: string = "";
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(StepFunctionsWorldImpl);

export function makeSession(): LwsSession {
  return new LwsSession();
}
