/**
 * CDK resource discovery — reads cdk.out cloud assembly to extract resources.
 *
 * Mirrors `lws_testing/_discovery/cdk.py`.
 */

import type { ResourceSpec } from "../specs.js";
import { DynamoTable, SqsQueue, S3Bucket } from "../specs.js";
import { readFileSync, existsSync } from "fs";
import { join } from "path";

export function discoverFromCdk(projectDir: string = "."): ResourceSpec[] {
  const manifestPath = join(projectDir, "cdk.out", "manifest.json");
  if (!existsSync(manifestPath)) {
    throw new Error(
      `cdk.out/manifest.json not found at ${manifestPath}. Run 'npx cdk synth' first.`,
    );
  }

  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as {
    artifacts?: Record<string, { type?: string; metadata?: Record<string, unknown[]> }>;
  };

  const resources: ResourceSpec[] = [];

  for (const artifact of Object.values(manifest.artifacts ?? {})) {
    if (artifact.type !== "aws:cloudformation:stack") continue;

    const metaKeys = Object.keys(artifact.metadata ?? {});
    const firstKey = metaKeys[0];
    if (firstKey === undefined) continue;

    const templatePath = join(projectDir, "cdk.out", `${firstKey}.template.json`);
    if (!existsSync(templatePath)) continue;

    const template = JSON.parse(readFileSync(templatePath, "utf8")) as {
      Resources?: Record<string, { Type: string; Properties?: Record<string, unknown> }>;
    };

    for (const [, resource] of Object.entries(template.Resources ?? {})) {
      if (resource.Type === "AWS::DynamoDB::Table") {
        const props = resource.Properties ?? {};
        const tableName = typeof props["TableName"] === "string" ? props["TableName"] : "UnnamedTable";
        const keySchema = (props["KeySchema"] as Array<{ AttributeName: string; KeyType: string }> | undefined) ?? [];
        const hashKey = keySchema.find((k) => k.KeyType === "HASH")?.AttributeName ?? "id";
        resources.push(new DynamoTable(tableName, hashKey));
      } else if (resource.Type === "AWS::SQS::Queue") {
        const props = resource.Properties ?? {};
        const name = typeof props["QueueName"] === "string" ? props["QueueName"] : "UnnamedQueue";
        resources.push(new SqsQueue(name));
      } else if (resource.Type === "AWS::S3::Bucket") {
        const props = resource.Properties ?? {};
        const name = typeof props["BucketName"] === "string" ? props["BucketName"] : "unnamed-bucket";
        resources.push(new S3Bucket(name));
      }
    }
  }

  return resources;
}
