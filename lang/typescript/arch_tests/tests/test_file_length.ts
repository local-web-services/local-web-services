/**
 * No source file in src/ may exceed 500 lines.
 * This prevents files from becoming too large to review.
 */

import { describe, it, expect } from "vitest";
import { readFileSync, readdirSync, statSync } from "fs";
import { join, relative } from "path";
import { fileURLToPath } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const TS_ROOT = join(__dirname, "../../");
const display = (f: string): string => relative(TS_ROOT, f);
const MAX_LINES = 500;

function findSourceFiles(dir: string): string[] {
  const results: string[] = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    const stat = statSync(full);
    if (stat.isDirectory() && entry !== "node_modules" && entry !== "dist" && entry !== "arch_tests") {
      results.push(...findSourceFiles(full));
    } else if (stat.isFile() && entry.endsWith(".ts") && full.includes("/src/")) {
      results.push(full);
    }
  }
  return results;
}

describe("Architecture — source file length", () => {
  const sourceFiles = findSourceFiles(TS_ROOT);

  it(`no source file exceeds ${MAX_LINES} lines`, () => {
    // Arrange
    const violations: string[] = [];

    // Act
    for (const file of sourceFiles) {
      const content = readFileSync(file, "utf8");
      const lineCount = content.split("\n").length;
      if (lineCount > MAX_LINES) {
        violations.push(`${display(file)} (${lineCount} lines > ${MAX_LINES})`);
      }
    }

    // Assert
    expect(violations).toEqual([]);
  });
});
