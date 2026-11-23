import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { SecretsManagerClient } from "@aws-sdk/client-secrets-manager";
import { LwsSession } from "../../../../src/index.js";

export const TEST_SECRET_NAME = "lws-e2e-test-secret";
export const TEST_SECRET_VALUE = "lws-e2e-secret-value-123";

export interface SecretsWorld extends CucumberWorld {
  session: LwsSession;
  secretsClient: SecretsManagerClient;
  error: Error | null;
  result: unknown;
}

class SecretsWorldImpl extends CucumberWorld implements SecretsWorld {
  declare session: LwsSession;
  declare secretsClient: SecretsManagerClient;
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(SecretsWorldImpl);
