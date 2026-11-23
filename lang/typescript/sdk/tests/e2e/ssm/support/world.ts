import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { SSMClient } from "@aws-sdk/client-ssm";
import { LwsSession } from "../../../../src/index.js";

export const TEST_PARAM_NAME = "/lws/e2e/test-param";
export const TEST_PARAM_VALUE = "lws-e2e-param-value";

export interface SsmWorld extends CucumberWorld {
  session: LwsSession;
  ssmClient: SSMClient;
  error: Error | null;
  result: unknown;
}

class SsmWorldImpl extends CucumberWorld implements SsmWorld {
  declare session: LwsSession;
  declare ssmClient: SSMClient;
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(SsmWorldImpl);
