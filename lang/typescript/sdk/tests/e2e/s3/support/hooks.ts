import { Before, After, BeforeAll, AfterAll } from "@cucumber/cucumber";
import { S3Client } from "@aws-sdk/client-s3";
import { LwsSession, S3Bucket } from "../../../../src/index.js";
import type { S3World } from "./world.js";
import { TEST_BUCKET_NAME } from "./world.js";

let sharedSession: LwsSession | null = null;
let sharedS3Client: S3Client | null = null;

BeforeAll(async function () {
  sharedSession = new LwsSession(new S3Bucket(TEST_BUCKET_NAME));
  await sharedSession.start();
  sharedS3Client = new S3Client(sharedSession.clientConfig("s3"));
});

AfterAll(async function () {
  await sharedSession?.stop();
  sharedSession = null;
  sharedS3Client = null;
});

Before(async function (this: S3World) {
  if (sharedSession === null || sharedS3Client === null) {
    throw new Error("S3 session not initialized");
  }
  this.session = sharedSession;
  this.s3Client = sharedS3Client;
  this.error = null;
  this.result = null;
  await this.session.reset();
});

After(async function (this: S3World) {
  this.error = null;
  this.result = null;
});
