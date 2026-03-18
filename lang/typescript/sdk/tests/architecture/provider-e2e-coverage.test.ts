import * as path from "path";
import * as fs from "fs";

describe("Provider E2E Coverage", () => {
  it("every core provider has a corresponding e2e suite in sdk/tests/steps", () => {
    // Arrange
    const coreProvidersDir = path.join(
      __dirname,
      "..",
      "..",
      "..",
      "..",
      "core",
      "src",
      "providers",
    );
    const sdkStepsDir = path.join(__dirname, "..", "steps");

    // Act
    const coreProviders = fs.existsSync(coreProvidersDir)
      ? fs
          .readdirSync(coreProvidersDir, { withFileTypes: true })
          .filter((e) => e.isDirectory())
          .map((e) => e.name)
      : [];

    const sdkStepFiles = fs.existsSync(sdkStepsDir)
      ? fs.readdirSync(sdkStepsDir).map((f) => path.basename(f, ".ts").toLowerCase())
      : [];

    const missing: string[] = [];
    for (const provider of coreProviders) {
      const hasSteps = sdkStepFiles.some((f) => f.includes(provider.replace(/-/g, "")));
      if (!hasSteps) {
        missing.push(provider);
      }
    }

    // Assert
    const expectedMissing: string[] = [];
    const actualMissing = missing.filter((p) => !expectedMissing.includes(p));
    expect(actualMissing).toEqual([]);
  });
});
