/**
 * Minimal Terraform HCL parser for discovering AWS resources in .tf files.
 *
 * Supports the subset of HCL needed for common AWS resource types, including
 * heredoc strings (<<MARKER ... MARKER) used for multi-line JSON definitions.
 */

import * as fs from "fs";
import * as path from "path";

import type {
  ResourceSpec,
  TableSpec,
  QueueSpec,
  StateMachineSpec,
  ParameterSpec,
  SecretSpec,
} from "../types";

const RESOURCE_HEADER = /resource\s+"(?<type>[^"]+)"\s+"(?<logical>[^"]+)"\s*\{/;
const ATTR_STR = /^\s*(?<key>\w+)\s*=\s*"(?<value>[^"]*)"/;
const ATTR_BARE = /^\s*(?<key>\w+)\s*=\s*(?<value>\S+)/;
const ATTR_HEREDOC = /^\s*(?<key>\w+)\s*=\s*<<(?<marker>\w+)\s*$/;

interface ParsedResource {
  type: string;
  logical: string;
  attrs: Record<string, string>;
}

/**
 * Parse all .tf files in `projectDir` and return a ResourceSpec with
 * discovered AWS resources ready for use with LwsSession.
 */
export function discoverHcl(projectDir: string): ResourceSpec {
  const tfFiles: string[] = [];

  function findTfFiles(dir: string): void {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      if (entry.isDirectory() && !entry.name.startsWith(".")) {
        findTfFiles(path.join(dir, entry.name));
      } else if (entry.name.endsWith(".tf")) {
        tfFiles.push(path.join(dir, entry.name));
      }
    }
  }

  findTfFiles(projectDir);

  if (tfFiles.length === 0) {
    throw new Error(
      `No .tf files found in ${projectDir}. ` +
        "Make sure you point to the directory containing your Terraform files."
    );
  }

  const resources: ParsedResource[] = [];
  for (const tfFile of tfFiles) {
    resources.push(...parseTfFile(tfFile));
  }

  return classifyResources(resources);
}

function parseTfFile(filePath: string): ParsedResource[] {
  const text = fs.readFileSync(filePath, "utf-8");
  const lines = text.split("\n");
  const results: ParsedResource[] = [];
  let i = 0;

  while (i < lines.length) {
    const m = RESOURCE_HEADER.exec(lines[i]);
    if (m?.groups) {
      const { type, logical } = m.groups;
      const [attrs, nextI] = collectBlock(lines, i + 1);
      results.push({ type, logical, attrs });
      i = nextI;
    } else {
      i++;
    }
  }

  return results;
}

function collectBlock(
  lines: string[],
  start: number
): [Record<string, string>, number] {
  const attrs: Record<string, string> = {};
  let depth = 1;
  let i = start;

  while (i < lines.length && depth > 0) {
    const line = lines[i];

    // Handle heredoc (key = <<MARKER ... MARKER) before adjusting depth so
    // JSON content inside the heredoc does not affect brace counting.
    if (depth === 1) {
      const mHeredoc = ATTR_HEREDOC.exec(line);
      if (mHeredoc?.groups) {
        const { key, marker } = mHeredoc.groups;
        i++;
        const heredocLines: string[] = [];
        while (i < lines.length && lines[i].trimEnd() !== marker) {
          heredocLines.push(lines[i]);
          i++;
        }
        attrs[key] = heredocLines.join("\n");
        i++; // skip the closing marker line
        continue;
      }
    }

    const opens = (line.match(/\{/g) ?? []).length;
    const closes = (line.match(/\}/g) ?? []).length;
    depth += opens - closes;

    if (depth > 1) {
      i++;
      continue;
    }
    if (depth === 0) break;

    const mStr = ATTR_STR.exec(line);
    if (mStr?.groups) {
      attrs[mStr.groups.key] = mStr.groups.value;
    } else {
      const mBare = ATTR_BARE.exec(line);
      if (mBare?.groups) {
        attrs[mBare.groups.key] = mBare.groups.value;
      }
    }
    i++;
  }

  return [attrs, i + 1];
}

function classifyResources(resources: ParsedResource[]): ResourceSpec {
  const spec: ResourceSpec = {
    tables: [],
    queues: [],
    buckets: [],
    topics: [],
    stateMachines: [],
    parameters: [],
    secrets: [],
  };

  for (const { type, attrs } of resources) {
    switch (type) {
      case "aws_dynamodb_table": {
        const table = buildDynamoDBTable(attrs);
        if (table) spec.tables!.push(table);
        break;
      }
      case "aws_sqs_queue": {
        const queue = buildSqsQueue(attrs);
        if (queue) spec.queues!.push(queue);
        break;
      }
      case "aws_s3_bucket": {
        const bucket = buildS3Bucket(attrs);
        if (bucket) spec.buckets!.push(bucket);
        break;
      }
      case "aws_sns_topic": {
        const topic = buildSnsTopic(attrs);
        if (topic) spec.topics!.push(topic);
        break;
      }
      case "aws_sfn_state_machine": {
        const sm = buildStateMachine(attrs);
        if (sm) spec.stateMachines!.push(sm);
        break;
      }
      case "aws_ssm_parameter": {
        const param = buildSsmParameter(attrs);
        if (param) spec.parameters!.push(param);
        break;
      }
      case "aws_secretsmanager_secret": {
        const secret = buildSecretsManagerSecret(attrs);
        if (secret) spec.secrets!.push(secret);
        break;
      }
    }
  }

  return spec;
}

function buildDynamoDBTable(attrs: Record<string, string>): TableSpec | null {
  if (!attrs["name"]) return null;
  const table: TableSpec = {
    name: attrs["name"],
    partitionKey: attrs["hash_key"] ?? "id",
  };
  if (attrs["range_key"]) {
    table.sortKey = attrs["range_key"];
  }
  return table;
}

function buildSqsQueue(attrs: Record<string, string>): QueueSpec | null {
  if (!attrs["name"]) return null;
  const queue: QueueSpec = { name: attrs["name"] };
  if (attrs["fifo_queue"] === "true") {
    queue.isFifo = true;
  }
  return queue;
}

function buildS3Bucket(
  attrs: Record<string, string>
): { name: string } | null {
  const name = attrs["bucket"] ?? attrs["name"];
  if (!name) return null;
  return { name };
}

function buildSnsTopic(
  attrs: Record<string, string>
): { name: string } | null {
  if (!attrs["name"]) return null;
  return { name: attrs["name"] };
}

function buildStateMachine(
  attrs: Record<string, string>
): StateMachineSpec | null {
  if (!attrs["name"]) return null;
  return {
    name: attrs["name"],
    definition: attrs["definition"] ?? "{}",
    roleArn: attrs["role_arn"],
  };
}

function buildSsmParameter(
  attrs: Record<string, string>
): ParameterSpec | null {
  if (!attrs["name"]) return null;
  const param: ParameterSpec = { name: attrs["name"] };
  if (attrs["value"]) param.value = attrs["value"];
  if (attrs["type"]) param.type = attrs["type"] as ParameterSpec["type"];
  return param;
}

function buildSecretsManagerSecret(
  attrs: Record<string, string>
): SecretSpec | null {
  if (!attrs["name"]) return null;
  const secret: SecretSpec = { name: attrs["name"] };
  if (attrs["description"]) secret.description = attrs["description"];
  return secret;
}
