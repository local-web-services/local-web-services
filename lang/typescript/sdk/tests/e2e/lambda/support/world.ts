import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { LambdaClient } from "@aws-sdk/client-lambda";
import { LwsSession } from "../../../../src/index.js";

export const TEST_FUNCTION_NAME = "lws-e2e-test-function";

export interface LambdaWorld extends CucumberWorld {
  session: LwsSession;
  lambdaClient: LambdaClient;
  functionArn: string;
  error: Error | null;
  result: unknown;
}

class LambdaWorldImpl extends CucumberWorld implements LambdaWorld {
  declare session: LwsSession;
  declare lambdaClient: LambdaClient;
  functionArn: string = "";
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(LambdaWorldImpl);

export function makeSession(): LwsSession {
  return new LwsSession();
}
