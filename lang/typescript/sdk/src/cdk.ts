/**
 * CDK Cloud Assembly parser — public API for LwsSession.fromCdk().
 *
 * Mirrors `lws_testing/_discovery/cdk.py`.
 */

import { readFileSync, existsSync, statSync } from "fs";
import { join, extname } from "path";
import { load as yamlLoad } from "js-yaml";
import type { ResourceSpec } from "./specs.js";
import {
  DynamoTable,
  SqsQueue,
  S3Bucket,
  SnsTopic,
  SsmParameter,
  Secret,
  EventBus,
  StateMachine,
  CognitoUserPool,
  LambdaFunction,
} from "./specs.js";

export interface FromCdkOptions {
  /** Path to a cdk.out/ assembly directory, a parent project dir, or a direct .json/.yaml template file. Defaults to ".". */
  assemblyPath?: string;
  /** Only include stacks whose logical name starts with this prefix. */
  stackFilter?: string;
}

type CfTemplate = {
  Resources?: Record<string, { Type: string; Properties?: Record<string, unknown> }>;
};

type Manifest = {
  artifacts?: Record<string, {
    type?: string;
    properties?: { templateFile?: string };
    metadata?: Record<string, unknown[]>;
  }>;
};

function resolveIntrinsic(value: unknown): string {
  if (typeof value === "string") return value;
  if (typeof value !== "object" || value === null) return "";
  const obj = value as Record<string, unknown>;
  if ("Ref" in obj && typeof obj["Ref"] === "string") return obj["Ref"];
  if ("Fn::Join" in obj) {
    const args = obj["Fn::Join"] as [string, unknown[]];
    const delimiter = typeof args[0] === "string" ? args[0] : "";
    const parts = Array.isArray(args[1]) ? args[1] : [];
    return parts.map(resolveIntrinsic).join(delimiter);
  }
  if ("Fn::Sub" in obj) {
    const template = typeof obj["Fn::Sub"] === "string" ? obj["Fn::Sub"] : "";
    return template.replace(/\$\{[^}]+\}/g, (m) => m.slice(2, -1));
  }
  if ("Fn::Select" in obj) {
    const args = obj["Fn::Select"] as [number, unknown[]];
    const index = typeof args[0] === "number" ? args[0] : 0;
    const list = Array.isArray(args[1]) ? args[1] : [];
    return resolveIntrinsic(list[index]);
  }
  return "";
}

function str(value: unknown, fallback: string): string {
  const resolved = resolveIntrinsic(value);
  return resolved !== "" ? resolved : fallback;
}

function parseTemplate(template: CfTemplate): ResourceSpec[] {
  const resources: ResourceSpec[] = [];
  for (const resource of Object.values(template.Resources ?? {})) {
    const props = resource.Properties ?? {};
    switch (resource.Type) {
      case "AWS::DynamoDB::Table": {
        const name = str(props["TableName"], "UnnamedTable");
        const keySchema = (props["KeySchema"] as Array<{ AttributeName: string; KeyType: string }> | undefined) ?? [];
        const hashKey = keySchema.find((k) => k.KeyType === "HASH")?.AttributeName ?? "id";
        resources.push(new DynamoTable(name, hashKey));
        break;
      }
      case "AWS::SQS::Queue": {
        const name = str(props["QueueName"], "UnnamedQueue");
        resources.push(new SqsQueue(name));
        break;
      }
      case "AWS::S3::Bucket": {
        const name = str(props["BucketName"], "unnamed-bucket");
        resources.push(new S3Bucket(name));
        break;
      }
      case "AWS::SNS::Topic": {
        const name = str(props["TopicName"], "unnamed-topic");
        resources.push(new SnsTopic(name));
        break;
      }
      case "AWS::SSM::Parameter": {
        const name = str(props["Name"], "/unnamed");
        const value = str(props["Value"], "");
        const rawType = resolveIntrinsic(props["Type"]);
        const type = (rawType === "SecureString" || rawType === "StringList") ? rawType as "SecureString" | "StringList" : "String";
        resources.push(new SsmParameter(name, value, type));
        break;
      }
      case "AWS::SecretsManager::Secret": {
        const name = str(props["Name"], "unnamed-secret");
        resources.push(new Secret(name));
        break;
      }
      case "AWS::Events::EventBus": {
        const name = str(props["Name"], "unnamed-bus");
        resources.push(new EventBus(name));
        break;
      }
      case "AWS::StepFunctions::StateMachine": {
        const name = str(props["StateMachineName"], "unnamed-machine");
        const definition = str(props["DefinitionString"], "{}");
        resources.push(new StateMachine(name, definition));
        break;
      }
      case "AWS::Cognito::UserPool": {
        const name = str(props["UserPoolName"], "unnamed-pool");
        resources.push(new CognitoUserPool(name));
        break;
      }
      case "AWS::Lambda::Function": {
        const name = str(props["FunctionName"], "unnamed-function");
        const handler = str(props["Handler"], "index.handler");
        const rawRuntime = resolveIntrinsic(props["Runtime"]);
        const runtime = (rawRuntime === "nodejs18.x" || rawRuntime === "nodejs16.x") ? rawRuntime : "nodejs20.x";
        const env = props["Environment"] as { Variables?: Record<string, string> } | undefined;
        resources.push(new LambdaFunction(name, handler, runtime, undefined, env?.Variables ?? {}));
        break;
      }
    }
  }
  return resources;
}

function loadTemplate(filePath: string): CfTemplate {
  const content = readFileSync(filePath, "utf8");
  const ext = extname(filePath).toLowerCase();
  if (ext === ".yaml" || ext === ".yml") {
    return yamlLoad(content) as CfTemplate;
  }
  return JSON.parse(content) as CfTemplate;
}

export function parseCdkAssembly(options?: FromCdkOptions): ResourceSpec[] {
  const assemblyPath = options?.assemblyPath ?? ".";
  const stackFilter = options?.stackFilter;

  if (existsSync(assemblyPath) && statSync(assemblyPath).isFile()) {
    return parseTemplate(loadTemplate(assemblyPath));
  }

  // Resolve the cdk.out directory: either the path itself or a subdirectory
  const cdkOutDir = existsSync(join(assemblyPath, "manifest.json"))
    ? assemblyPath
    : join(assemblyPath, "cdk.out");

  const manifestPath = join(cdkOutDir, "manifest.json");
  if (!existsSync(manifestPath)) {
    throw new Error(
      `CDK manifest not found at ${manifestPath}. Run 'npx cdk synth' first.`,
    );
  }

  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as Manifest;
  const resources: ResourceSpec[] = [];

  for (const [stackName, artifact] of Object.entries(manifest.artifacts ?? {})) {
    if (artifact.type !== "aws:cloudformation:stack") continue;
    if (stackFilter !== undefined && !stackName.startsWith(stackFilter)) continue;

    // CDK v2+: properties.templateFile; older: derive from first metadata key
    const templateFile =
      artifact.properties?.templateFile ??
      `${Object.keys(artifact.metadata ?? {})[0] ?? stackName}.template.json`;

    const templatePath = join(cdkOutDir, templateFile);
    if (!existsSync(templatePath)) continue;

    resources.push(...parseTemplate(loadTemplate(templatePath)));
  }

  return resources;
}
