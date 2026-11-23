import { describe, it, expect } from "vitest";
import { existsSync, readdirSync, readFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const distDir = join(__dirname, "../../dist");

describe("JavaScript SDK dist (run `make build` before this suite)", () => {
  it("dist directory exists", () => {
    // Arrange
    const expectedPath = distDir;

    // Act
    const actualExists = existsSync(expectedPath);

    // Assert
    expect(actualExists).toBe(true);
  });

  it("CJS bundle exists at dist/index.cjs", () => {
    // Arrange
    const expectedPath = join(distDir, "index.cjs");

    // Act
    const actualExists = existsSync(expectedPath);

    // Assert
    expect(actualExists).toBe(true);
  });

  it("ESM bundle exists at dist/index.js", () => {
    // Arrange
    const expectedPath = join(distDir, "index.js");

    // Act
    const actualExists = existsSync(expectedPath);

    // Assert
    expect(actualExists).toBe(true);
  });

  it("dist contains no .d.ts files", () => {
    // Arrange
    const allFiles = readdirSync(distDir);
    const expectedDtsCount = 0;

    // Act
    const actualDtsFiles = allFiles.filter((f) => f.endsWith(".d.ts"));

    // Assert
    expect(actualDtsFiles).toHaveLength(expectedDtsCount);
  });

  it("CJS bundle references LwsSession", () => {
    // Arrange
    const cjsPath = join(distDir, "index.cjs");

    // Act
    const actualContent = readFileSync(cjsPath, "utf8");

    // Assert
    expect(actualContent).toContain("LwsSession");
  });

  it("ESM bundle references LwsSession", () => {
    // Arrange
    const esmPath = join(distDir, "index.js");

    // Act
    const actualContent = readFileSync(esmPath, "utf8");

    // Assert
    expect(actualContent).toContain("LwsSession");
  });

  it("CJS bundle references SqsQueue", () => {
    // Arrange
    const cjsPath = join(distDir, "index.cjs");

    // Act
    const actualContent = readFileSync(cjsPath, "utf8");

    // Assert
    expect(actualContent).toContain("SqsQueue");
  });

  it("ESM bundle references ChaosBuilder", () => {
    // Arrange
    const esmPath = join(distDir, "index.js");

    // Act
    const actualContent = readFileSync(esmPath, "utf8");

    // Assert
    expect(actualContent).toContain("ChaosBuilder");
  });
});
