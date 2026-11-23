/**
 * Tests must never be skipped. No it.skip / describe.skip / test.skip / xit / xdescribe.
 * This matches the rule in contributing/testing/END_TO_END.md and Python's arch_tests.
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

const SKIP_PATTERNS = [
  /\bit\.skip\s*\(/,
  /\bdescribe\.skip\s*\(/,
  /\btest\.skip\s*\(/,
  /\bxit\s*\(/,
  /\bxdescribe\s*\(/,
  /vitest\.skip/,
];

describe("Architecture — no skipped tests", () => {
  const testFiles = findTestFiles(TS_ROOT);

  it("no test file uses a skip decorator or function", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of testFiles) {
      const content = readFileSync(file, "utf8");
      const lines = content.split("\n");
      for (let i = 0; i < lines.length; i++) {
        const line = lines[i] ?? "";
        if (SKIP_PATTERNS.some((pattern) => pattern.test(line))) {
          violations.push(`${display(file)}:${i + 1}`);
        }
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });
});
