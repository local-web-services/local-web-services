/**
 * Terraform/HCL resource discovery — reads .tf files to extract resources.
 *
 * Mirrors `lws_testing/_discovery/hcl.py`.
 */

import type { ResourceSpec } from "../specs.js";
import { DynamoTable, SqsQueue, S3Bucket } from "../specs.js";
import { readdirSync, readFileSync } from "fs";
import { join } from "path";

const RESOURCE_RE = /resource\s+"([^"]+)"\s+"([^"]+)"\s*\{([^}]*(?:\{[^}]*\}[^}]*)*)\}/gs;

function extractAttr(block: string, attr: string): string | undefined {
  const re = new RegExp(`^\\s*${attr}\\s*=\\s*"([^"]*)"`, "m");
  return re.exec(block)?.[1];
}

export function discoverFromHcl(projectDir: string = "."): ResourceSpec[] {
  const tfFiles = readdirSync(projectDir).filter((f) => f.endsWith(".tf"));
  const resources: ResourceSpec[] = [];

  for (const file of tfFiles) {
    const content = readFileSync(join(projectDir, file), "utf8");
    for (const match of content.matchAll(RESOURCE_RE)) {
      const [, type, , body] = match;
      if (type === "aws_dynamodb_table") {
        const name = extractAttr(body ?? "", "name") ?? "UnnamedTable";
        const hashKey = extractAttr(body ?? "", "hash_key") ?? "id";
        resources.push(new DynamoTable(name, hashKey));
      } else if (type === "aws_sqs_queue") {
        const name = extractAttr(body ?? "", "name") ?? "UnnamedQueue";
        resources.push(new SqsQueue(name));
      } else if (type === "aws_s3_bucket") {
        const name = extractAttr(body ?? "", "bucket") ?? "unnamed-bucket";
        resources.push(new S3Bucket(name));
      }
    }
  }

  return resources;
}
