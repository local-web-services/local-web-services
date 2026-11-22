import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { LwsSession } from "../../../../src/index.js";

export const TEST_TABLE = "lws-e2e-dynamo-table";
export const TEST_PK = "lws-e2e-pk";

export interface DynamoWorld extends CucumberWorld {
  session: LwsSession;
  dynamoClient: DynamoDBClient;
  error: Error | null;
  result: unknown;
  item: Record<string, unknown> | null;
}

class DynamoWorldImpl extends CucumberWorld implements DynamoWorld {
  declare session: LwsSession;
  declare dynamoClient: DynamoDBClient;
  error: Error | null = null;
  result: unknown = null;
  item: Record<string, unknown> | null = null;
}

setWorldConstructor(DynamoWorldImpl);
