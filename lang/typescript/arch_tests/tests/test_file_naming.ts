/**
 * Test files must be named test_<subject>.ts (snake_case, test_ prefix).
 * This matches the Python convention enforced in arch_tests/test_file_naming.py.
 */

import { describe, it, expect } from "vitest";
import { readdirSync, statSync } from "fs";
import { join, relative } from "path";
import { fileURLToPath } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const TS_ROOT = join(__dirname, "../../");
const display = (f: string): string => relative(TS_ROOT, f);

// Directories where non-test_ prefixed files are allowed (step defs, support, hooks)
const ALLOWED_NON_TEST_DIRS = ["step_definitions", "support", "given", "when", "then"];
// File names allowed without the test_ prefix (helpers, constants, fixtures)
const ALLOWED_NON_TEST_FILES = new Set(["world.ts", "hooks.ts", "client.ts", "constants.ts"]);

function findAllTestFiles(dir: string): string[] {
  const results: string[] = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    const stat = statSync(full);
    if (stat.isDirectory() && entry !== "node_modules" && entry !== "dist" && entry !== "arch_tests") {
      results.push(...findAllTestFiles(full));
    } else if (stat.isFile() && entry.endsWith(".ts") && full.includes("/tests/")) {
      results.push(full);
    }
  }
  return results;
}

describe("Architecture — test file naming", () => {
  const testFiles = findAllTestFiles(TS_ROOT);

  it("every test file starts with test_ prefix", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of testFiles) {
      const basename = file.split("/").pop() ?? "";
      if (ALLOWED_NON_TEST_FILES.has(basename)) continue;
      if (ALLOWED_NON_TEST_DIRS.some((d) => file.includes(`/${d}/`))) continue;
      if (!basename.startsWith("test_")) {
        violations.push(display(file));
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });

  it("test file names use snake_case (no uppercase letters)", () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of testFiles) {
      const basename = file.split("/").pop()?.replace(".ts", "") ?? "";
      if (basename !== basename.toLowerCase()) {
        violations.push(display(file));
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });
});
