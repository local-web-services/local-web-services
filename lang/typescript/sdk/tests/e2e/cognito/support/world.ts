import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { CognitoIdentityProviderClient } from "@aws-sdk/client-cognito-identity-provider";
import { LwsSession } from "../../../../src/index.js";

export const TEST_POOL_NAME = "lws-e2e-test-pool";
export const TEST_USERNAME = "lws-e2e-user";
export const TEST_PASSWORD = "TestPass1!";

export interface CognitoWorld extends CucumberWorld {
  session: LwsSession;
  cognitoClient: CognitoIdentityProviderClient;
  poolId: string;
  clientId: string;
  accessToken: string;
  error: Error | null;
  result: unknown;
}

class CognitoWorldImpl extends CucumberWorld implements CognitoWorld {
  declare session: LwsSession;
  declare cognitoClient: CognitoIdentityProviderClient;
  poolId: string = "";
  clientId: string = "";
  accessToken: string = "";
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(CognitoWorldImpl);

export function makeSession(): LwsSession {
  return new LwsSession();
}
