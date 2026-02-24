"use strict";

/**
 * Minimal Terraform HCL parser for discovering AWS resources in .tf files.
 *
 * Supports the subset of HCL needed for common AWS resource types, including
 * heredoc strings (<<MARKER ... MARKER) used for multi-line JSON definitions.
 */

const fs = require("fs");
const path = require("path");

const RESOURCE_HEADER = /resource\s+"(?<type>[^"]+)"\s+"(?<logical>[^"]+)"\s*\{/;
const ATTR_STR = /^\s*(?<key>\w+)\s*=\s*"(?<value>[^"]*)"/;
const ATTR_BARE = /^\s*(?<key>\w+)\s*=\s*(?<value>\S+)/;
const ATTR_HEREDOC = /^\s*(?<key>\w+)\s*=\s*<<(?<marker>\w+)\s*$/;

/**
 * Parse all .tf files in `projectDir` and return a resource spec object with
 * discovered AWS resources ready for use with LwsSession.
 *
 * @param {string} projectDir
 * @returns {{ stateMachines?: Array<{ name: string, definition?: string, roleArn?: string }> }}
 */
function discoverHcl(projectDir) {
  const tfFiles = [];

  function findTfFiles(dir) {
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

  const resources = [];
  for (const tfFile of tfFiles) {
    resources.push(...parseTfFile(tfFile));
  }

  return classifyResources(resources);
}

function parseTfFile(filePath) {
  const text = fs.readFileSync(filePath, "utf-8");
  const lines = text.split("\n");
  const results = [];
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

function collectBlock(lines, start) {
  const attrs = {};
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
        const heredocLines = [];
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

function classifyResources(resources) {
  const spec = { stateMachines: [] };

  for (const { type, attrs } of resources) {
    if (type === "aws_sfn_state_machine") {
      const sm = buildStateMachine(attrs);
      if (sm) spec.stateMachines.push(sm);
    }
  }

  return spec;
}

function buildStateMachine(attrs) {
  if (!attrs["name"]) return null;
  return {
    name: attrs["name"],
    definition: attrs["definition"] ?? "{}",
    roleArn: attrs["role_arn"],
  };
}

module.exports = { discoverHcl };
