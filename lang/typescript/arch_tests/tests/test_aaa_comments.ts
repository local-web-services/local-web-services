/**
 * Every unit test body must contain both a "// Act" and a "// Assert" comment.
 * This enforces the Arrange / Act / Assert pattern defined in contributing/testing/COMMON.md.
 */

import { describe, it, expect } from "vitest";
import { readFileSync, readdirSync, statSync } from "fs";
import { join, relative } from "path";
import { fileURLToPath } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const TS_ROOT = join(__dirname, "../../");
const display = (f: string): string => relative(TS_ROOT, f);

function findTestFiles(dir: string): string[] {
  const results: string[] = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    const stat = statSync(full);
    if (stat.isDirectory() && entry !== "node_modules" && entry !== "dist" && entry !== "arch_tests") {
      results.push(...findTestFiles(full));
    } else if (stat.isFile() && entry.startsWith("test_") && entry.endsWith(".ts")) {
      results.push(full);
    }
  }
  return results;
}

function extractTestBodies(content: string): string[] {
  const bodies: string[] = [];
  const itStartPattern = /\bit\s*\(/g;
  const matches = [...content.matchAll(itStartPattern)];
  for (const match of matches) {
    let depth = 0;
    let start = -1;
    for (let i = match.index ?? 0; i < content.length; i++) {
      if (content[i] === "{") {
        if (depth === 0) start = i;
        depth++;
      } else if (content[i] === "}") {
        depth--;
        if (depth === 0 && start !== -1) {
          bodies.push(content.slice(start, i + 1));
          break;
        }
      }
    }
  }
  return bodies;
}

describe("Architecture — AAA comments in unit tests", () => {
  const unitTestFiles = findTestFiles(TS_ROOT).filter((f) => f.includes("/tests/unit/"));

  it("every unit test it() block contains a // Act comment", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of unitTestFiles) {
      const content = readFileSync(file, "utf8");
      const bodies = extractTestBodies(content);
      for (let i = 0; i < bodies.length; i++) {
        if (!bodies[i]!.includes("// Act")) {
          violations.push(`${display(file)}:test#${i + 1} missing // Act`);
        }
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });

  it("every unit test it() block contains a // Assert comment", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of unitTestFiles) {
      const content = readFileSync(file, "utf8");
      const bodies = extractTestBodies(content);
      for (let i = 0; i < bodies.length; i++) {
        if (!bodies[i]!.includes("// Assert")) {
          violations.push(`${display(file)}:test#${i + 1} missing // Assert`);
        }
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });
});
