import { describe, it, expect, beforeEach } from "vitest";
import { CognitoProvider } from "../../../../src/providers/cognito/provider.js";

describe("CognitoProvider admin user state", () => {
  let provider: CognitoProvider;
  let poolId: string;
  let clientId: string;

  beforeEach(async () => {
    provider = new CognitoProvider([]);
    await provider.start();
    const pool = await provider.createUserPool("admin-pool");
    poolId = pool.UserPool["Id"] as string;
    const client = provider.createUserPoolClient(poolId, "admin-client");
    clientId = client.UserPoolClient["ClientId"] as string;
    provider.adminCreateUser(poolId, "user1", "Pass1!");
  });

  it("adminDisableUser sets Enabled to false", () => {
    // Arrange
    const expectedEnabled = false;

    // Act
    provider.adminDisableUser(poolId, "user1");
    const actual = provider.adminGetUser(poolId, "user1");

    // Assert
    expect(actual["Enabled"]).toBe(expectedEnabled);
  });

  it("adminEnableUser sets Enabled to true after disable", () => {
    // Arrange
    provider.adminDisableUser(poolId, "user1");
    const expectedEnabled = true;

    // Act
    provider.adminEnableUser(poolId, "user1");
    const actual = provider.adminGetUser(poolId, "user1");

    // Assert
    expect(actual["Enabled"]).toBe(expectedEnabled);
  });

  it("adminConfirmSignUp sets status to CONFIRMED", () => {
    // Arrange
    const expectedStatus = "CONFIRMED";

    // Act
    provider.adminConfirmSignUp(poolId, "user1");
    const actual = provider.adminGetUser(poolId, "user1");

    // Assert
    expect(actual["UserStatus"]).toBe(expectedStatus);
  });

  it("forgotPassword and confirmForgotPassword allow password change", async () => {
    // Arrange
    const expectedNewPassword = "NewPass456!";

    // Act
    provider.forgotPassword(clientId, "user1");
    provider.confirmForgotPassword(clientId, "user1", "ANY_CODE", expectedNewPassword);
    const auth = await provider.initiateAuth(clientId, "USER_PASSWORD_AUTH", {
      USERNAME: "user1",
      PASSWORD: expectedNewPassword,
    });

    // Assert
    const expectedAccessTokenType = "string";
    expect(typeof auth.AuthenticationResult["AccessToken"]).toBe(expectedAccessTokenType);
  });

  it("adminUpdateUserAttributes merges new attributes", () => {
    // Arrange
    const expectedAttrName = "custom:role";
    const expectedAttrValue = "superuser";

    // Act
    provider.adminUpdateUserAttributes(poolId, "user1", [{ Name: expectedAttrName, Value: expectedAttrValue }]);
    const actual = provider.adminGetUser(poolId, "user1");

    // Assert
    const attrs = actual["Attributes"] as { Name: string; Value: string }[];
    const found = attrs.find((a) => a.Name === expectedAttrName);
    expect(found?.Value).toBe(expectedAttrValue);
  });

  it("respondToAuthChallenge NEW_PASSWORD_REQUIRED issues tokens", async () => {
    // Arrange
    const expectedTokenType = "string";

    // Act
    const actual = await provider.respondToAuthChallenge(clientId, "NEW_PASSWORD_REQUIRED", {
      USERNAME: "user1",
      NEW_PASSWORD: "Changed1!",
    });

    // Assert
    expect(typeof actual.AuthenticationResult["AccessToken"]).toBe(expectedTokenType);
    expect(typeof actual.AuthenticationResult["IdToken"]).toBe(expectedTokenType);
    const expectedExpiresIn = 3600;
    expect(actual.AuthenticationResult["ExpiresIn"]).toBe(expectedExpiresIn);
  });

  it("describeUserPoolClient returns client record", () => {
    // Arrange
    const expectedClientId = clientId;
    const expectedClientName = "admin-client";

    // Act
    const actual = provider.describeUserPoolClient(poolId, clientId);

    // Assert
    expect(actual.UserPoolClient["ClientId"]).toBe(expectedClientId);
    expect(actual.UserPoolClient["ClientName"]).toBe(expectedClientName);
  });
});
