/**
 * Assertions in unit tests must use expected_* / actual_* variables, not bare literals.
 * This enforces the rule in contributing/testing/COMMON.md.
 */

import { describe, it, expect } from "vitest";
import { readFileSync, readdirSync, statSync } from "fs";
import { join, relative } from "path";
import { fileURLToPath } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const TS_ROOT = join(__dirname, "../../");
const display = (f: string): string => relative(TS_ROOT, f);

function findUnitTestFiles(dir: string): string[] {
  const results: string[] = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    const stat = statSync(full);
    if (stat.isDirectory() && entry !== "node_modules" && entry !== "dist" && entry !== "arch_tests") {
      results.push(...findUnitTestFiles(full));
    } else if (stat.isFile() && entry.startsWith("test_") && entry.endsWith(".ts")) {
      if (full.includes("/tests/unit/")) results.push(full);
    }
  }
  return results;
}

function assertionLinesWithBareLiterals(content: string): number[] {
  const lines = content.split("\n");
  const violations: number[] = [];
  // Match expect(...).toBe("literal") or .toEqual("literal") with a string/number literal
  // that is not assigned to expected_* or actual_*
  const assertLinePattern = /^\s*expect\s*\(/;
  const bareLiteralPattern = /\.(toBe|toEqual|toStrictEqual|toContain)\s*\(\s*["'`\d-]/;
  const expectedVarPattern = /\.(toBe|toEqual|toStrictEqual|toContain)\s*\(\s*(expected_|actual_)/;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i] ?? "";
    if (assertLinePattern.test(line) && bareLiteralPattern.test(line) && !expectedVarPattern.test(line)) {
      // Allow some common non-string literals used as sentinels: null, true, false, undefined, 0, 1
      const allowedLiterals = /\.(toBe|toEqual|toStrictEqual|toContain)\s*\(\s*(null|true|false|undefined|0|1|2|-1)\s*\)/;
      if (!allowedLiterals.test(line)) {
        violations.push(i + 1);
      }
    }
  }
  return violations;
}

describe("Architecture — no magic strings in assertions", () => {
  const unitTestFiles = findUnitTestFiles(TS_ROOT);

  it("assertion matchers use expected_* or actual_* variables, not bare string literals", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of unitTestFiles) {
      const content = readFileSync(file, "utf8");
      const badLines = assertionLinesWithBareLiterals(content);
      for (const lineNum of badLines) {
        violations.push(`${display(file)}:${lineNum}`);
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });
});
