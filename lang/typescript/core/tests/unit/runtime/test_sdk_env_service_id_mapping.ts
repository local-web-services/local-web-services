import { describe, it, expect } from "vitest";
import { buildSdkEnv } from "../../../src/runtime/sdkEnv.js";

describe("buildSdkEnv", () => {
  it("maps standard service names to uppercase env vars", () => {
    // Arrange
    const expectedVar = "AWS_ENDPOINT_URL_DYNAMODB";
    const expectedUrl = "http://localhost:3001";

    // Act
    const env = buildSdkEnv({ dynamodb: expectedUrl });

    // Assert
    expect(env[expectedVar]).toBe(expectedUrl);
  });

  it("maps secretsmanager to SECRETS_MANAGER", () => {
    // Arrange
    const expectedVar = "AWS_ENDPOINT_URL_SECRETS_MANAGER";
    const expectedUrl = "http://localhost:3013";

    // Act
    const env = buildSdkEnv({ secretsmanager: expectedUrl });

    // Assert
    expect(env[expectedVar]).toBe(expectedUrl);
  });

  it("maps stepfunctions to SFN", () => {
    // Arrange
    const expectedVar = "AWS_ENDPOINT_URL_SFN";
    const expectedUrl = "http://localhost:3006";

    // Act
    const env = buildSdkEnv({ stepfunctions: expectedUrl });

    // Assert
    expect(env[expectedVar]).toBe(expectedUrl);
  });

  it("maps cognito-idp to COGNITO_IDENTITY_PROVIDER", () => {
    // Arrange
    const expectedVar = "AWS_ENDPOINT_URL_COGNITO_IDENTITY_PROVIDER";
    const expectedUrl = "http://localhost:3007";

    // Act
    const env = buildSdkEnv({ "cognito-idp": expectedUrl });

    // Assert
    expect(env[expectedVar]).toBe(expectedUrl);
  });

  it("maps events to EVENTBRIDGE", () => {
    // Arrange
    const expectedVar = "AWS_ENDPOINT_URL_EVENTBRIDGE";
    const expectedUrl = "http://localhost:3005";

    // Act
    const env = buildSdkEnv({ events: expectedUrl });

    // Assert
    expect(env[expectedVar]).toBe(expectedUrl);
  });

  it("always includes dummy credentials and region", () => {
    // Arrange
    const expectedKeyId = "ldk-local";
    const expectedRegion = "us-east-1";

    // Act
    const env = buildSdkEnv({});

    // Assert
    expect(env["AWS_ACCESS_KEY_ID"]).toBe(expectedKeyId);
    expect(env["AWS_DEFAULT_REGION"]).toBe(expectedRegion);
  });

  it("sets S3 path style when s3 endpoint is provided", () => {
    // Arrange
    const expectedPathStyle = "true";

    // Act
    const env = buildSdkEnv({ s3: "http://localhost:3003" });

    // Assert
    expect(env["AWS_S3_FORCE_PATH_STYLE"]).toBe(expectedPathStyle);
  });

  it("does not set S3 path style when no s3 endpoint", () => {
    // Arrange
    const unexpectedKey = "AWS_S3_FORCE_PATH_STYLE";

    // Act
    const env = buildSdkEnv({ dynamodb: "http://localhost:3001" });

    // Assert
    expect(unexpectedKey in env).toBe(false);
  });
});
