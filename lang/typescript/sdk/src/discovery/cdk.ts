/**
 * CDK resource discovery — reads cdk.out cloud assembly to extract resources.
 *
 * Mirrors `lws_testing/_discovery/cdk.py`.
 */

import type { ResourceSpec } from "../specs.js";
import { DynamoTable, SqsQueue, S3Bucket, SnsTopic, SsmParameter, Secret, EventBus, StateMachine, CognitoUserPool, LambdaFunction } from "../specs.js";
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
      } else if (resource.Type === "AWS::SNS::Topic") {
        const props = resource.Properties ?? {};
        const name = typeof props["TopicName"] === "string" ? props["TopicName"] : "unnamed-topic";
        resources.push(new SnsTopic(name));
      } else if (resource.Type === "AWS::SSM::Parameter") {
        const props = resource.Properties ?? {};
        const name = typeof props["Name"] === "string" ? props["Name"] : "/unnamed";
        const value = typeof props["Value"] === "string" ? props["Value"] : "";
        const type = (props["Type"] === "SecureString" || props["Type"] === "StringList") ? props["Type"] as "SecureString" | "StringList" : "String";
        resources.push(new SsmParameter(name, value, type));
      } else if (resource.Type === "AWS::SecretsManager::Secret") {
        const props = resource.Properties ?? {};
        const name = typeof props["Name"] === "string" ? props["Name"] : "unnamed-secret";
        resources.push(new Secret(name));
      } else if (resource.Type === "AWS::Events::EventBus") {
        const props = resource.Properties ?? {};
        const name = typeof props["Name"] === "string" ? props["Name"] : "unnamed-bus";
        resources.push(new EventBus(name));
      } else if (resource.Type === "AWS::StepFunctions::StateMachine") {
        const props = resource.Properties ?? {};
        const name = typeof props["StateMachineName"] === "string" ? props["StateMachineName"] : "unnamed-machine";
        const definition = typeof props["DefinitionString"] === "string" ? props["DefinitionString"] : "{}";
        resources.push(new StateMachine(name, definition));
      } else if (resource.Type === "AWS::Cognito::UserPool") {
        const props = resource.Properties ?? {};
        const name = typeof props["UserPoolName"] === "string" ? props["UserPoolName"] : "unnamed-pool";
        resources.push(new CognitoUserPool(name));
      } else if (resource.Type === "AWS::Lambda::Function") {
        const props = resource.Properties ?? {};
        const name = typeof props["FunctionName"] === "string" ? props["FunctionName"] : "unnamed-function";
        const code = props["Code"] as Record<string, unknown> | undefined;
        const handler = typeof props["Handler"] === "string" ? props["Handler"] : "index.handler";
        const runtime = typeof props["Runtime"] === "string" ? props["Runtime"] as "nodejs20.x" | "nodejs18.x" | "nodejs16.x" : "nodejs20.x";
        const codeDir = typeof code?.["S3Bucket"] === "string" ? undefined : (typeof code?.["ZipFile"] === "string" ? undefined : undefined);
        const env = props["Environment"] as { Variables?: Record<string, string> } | undefined;
        resources.push(new LambdaFunction(name, handler, runtime, codeDir, env?.Variables ?? {}));
      }
    }
  }

  return resources;
}
