import { setWorldConstructor, World as CucumberWorld } from "@cucumber/cucumber";
import type { S3Client } from "@aws-sdk/client-s3";
import { LwsSession } from "../../../../src/index.js";

export const TEST_BUCKET_NAME = "lws-e2e-test-bucket";
export const TEST_OBJECT_KEY = "lws-e2e/test-object.txt";
export const TEST_OBJECT_BODY = "lws-e2e-object-content";

export interface S3World extends CucumberWorld {
  session: LwsSession;
  s3Client: S3Client;
  error: Error | null;
  result: unknown;
}

class S3WorldImpl extends CucumberWorld implements S3World {
  declare session: LwsSession;
  declare s3Client: S3Client;
  error: Error | null = null;
  result: unknown = null;
}

setWorldConstructor(S3WorldImpl);
