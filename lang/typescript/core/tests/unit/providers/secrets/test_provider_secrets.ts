import { describe, it, expect, beforeEach } from "vitest";
import { SecretsProvider } from "../../../../src/providers/secrets/provider.js";

describe("SecretsProvider lifecycle", () => {
  it("starts and reports healthy", async () => {
    // Arrange
    const provider = new SecretsProvider([]);

    // Act
    await provider.start();

    // Assert
    const actualHealthy = await provider.healthCheck();
    expect(actualHealthy).toBe(true);
    await provider.stop();
  });

  it("pre-seeds secrets from config", async () => {
    // Arrange
    const expectedName = "my-secret";
    const expectedValue = "s3cr3t-v@lue";
    const provider = new SecretsProvider([{ name: expectedName, secretString: expectedValue }]);
    await provider.start();

    // Act
    const actualSecret = provider.getSecretValue(expectedName);

    // Assert
    expect(actualSecret.SecretString).toBe(expectedValue);
    await provider.stop();
  });
});

describe("SecretsProvider createSecret / getSecretValue", () => {
  let provider: SecretsProvider;

  beforeEach(async () => {
    provider = new SecretsProvider([]);
    await provider.start();
  });

  it("creates and retrieves a secret", () => {
    // Arrange
    const expectedName = "my-api-key";
    const expectedValue = "abc123";

    // Act
    provider.createSecret(expectedName, expectedValue);
    const actualSecret = provider.getSecretValue(expectedName);

    // Assert
    expect(actualSecret.Name).toBe(expectedName);
    expect(actualSecret.SecretString).toBe(expectedValue);
  });

  it("throws ResourceNotFoundException for missing secret", () => {
    // Arrange
    const expectedError = "ResourceNotFoundException";

    // Act
    const actualFn = () => provider.getSecretValue("nonexistent");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("throws ResourceExistsException when creating a duplicate", () => {
    // Arrange
    const expectedError = "ResourceExistsException";
    provider.createSecret("dup-secret", "v1");

    // Act
    const actualFn = () => provider.createSecret("dup-secret", "v2");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("generates an ARN with the secret name", () => {
    // Arrange
    const expectedNamePart = "my-token";

    // Act
    const actualSecret = provider.createSecret(expectedNamePart, "value");

    // Assert
    expect(actualSecret.ARN).toContain(expectedNamePart);
  });
});

describe("SecretsProvider putSecretValue / deleteSecret / listSecrets", () => {
  let provider: SecretsProvider;

  beforeEach(async () => {
    provider = new SecretsProvider([]);
    await provider.start();
    provider.createSecret("existing-secret", "original");
  });

  it("updates the secret string on putSecretValue", () => {
    // Arrange
    const expectedValue = "updated-value";

    // Act
    provider.putSecretValue("existing-secret", expectedValue);
    const actualSecret = provider.getSecretValue("existing-secret");

    // Assert
    expect(actualSecret.SecretString).toBe(expectedValue);
  });

  it("deletes a secret so it no longer exists", () => {
    // Arrange
    const expectedError = "ResourceNotFoundException";

    // Act
    provider.deleteSecret("existing-secret");
    const actualFn = () => provider.getSecretValue("existing-secret");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("lists all secrets", () => {
    // Arrange
    provider.createSecret("another-secret", "v");
    const expectedCount = 2;

    // Act
    const actualSecrets = provider.listSecrets();

    // Assert
    expect(actualSecrets).toHaveLength(expectedCount);
  });

  it("reset removes dynamic secrets but preserves seeded ones", async () => {
    // Arrange
    const seeded = new SecretsProvider([{ name: "seeded", secretString: "s" }]);
    await seeded.start();
    seeded.createSecret("dynamic", "d");
    const expectedPresentName = "seeded";
    const expectedAbsentName = "dynamic";

    // Act
    await seeded.reset();
    const actualNames = seeded.listSecrets().map((s) => s.Name);

    // Assert
    expect(actualNames).toContain(expectedPresentName);
    expect(actualNames).not.toContain(expectedAbsentName);
    await seeded.stop();
  });
});
