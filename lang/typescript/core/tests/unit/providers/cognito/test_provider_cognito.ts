import { describe, it, expect, beforeEach } from "vitest";
import { CognitoProvider } from "../../../../src/providers/cognito/provider.js";

describe("CognitoProvider lifecycle", () => {
  it("healthCheck returns true after start", async () => {
    // Arrange
    const provider = new CognitoProvider([]);

    // Act
    await provider.start();
    const actualHealth = await provider.healthCheck();

    // Assert
    const expectedHealth = true;
    expect(actualHealth).toBe(expectedHealth);

    await provider.stop();
  });
});

describe("CognitoProvider user pools", () => {
  let provider: CognitoProvider;

  beforeEach(async () => {
    provider = new CognitoProvider([]);
    await provider.start();
  });

  it("createUserPool returns pool with an Id", async () => {
    // Arrange
    const expectedName = "my-pool";

    // Act
    const actual = await provider.createUserPool(expectedName);

    // Assert
    const expectedIdType = "string";
    expect(actual.UserPool["Name"]).toBe(expectedName);
    expect(typeof actual.UserPool["Id"]).toBe(expectedIdType);
  });

  it("listUserPools includes created pool", async () => {
    // Arrange
    const expectedName = "list-pool";
    await provider.createUserPool(expectedName);

    // Act
    const actual = provider.listUserPools();

    // Assert
    const actualNames = actual.UserPools.map((p) => p["Name"]);
    expect(actualNames).toContain(expectedName);
  });

  it("createUserPoolClient returns a ClientId", async () => {
    // Arrange
    const pool = await provider.createUserPool("client-pool");
    const expectedClientName = "my-client";

    // Act
    const actual = provider.createUserPoolClient(pool.UserPool["Id"] as string, expectedClientName);

    // Assert
    const expectedClientIdType = "string";
    expect(actual.UserPoolClient["ClientName"]).toBe(expectedClientName);
    expect(typeof actual.UserPoolClient["ClientId"]).toBe(expectedClientIdType);
  });

  it("adminCreateUser creates a user retrievable via adminGetUser", async () => {
    // Arrange
    const pool = await provider.createUserPool("user-pool");
    const expectedUsername = "alice";

    // Act
    provider.adminCreateUser(pool.UserPool["Id"] as string, expectedUsername, "Pass1!");
    const actual = provider.adminGetUser(pool.UserPool["Id"] as string, expectedUsername);

    // Assert
    expect(actual["Username"]).toBe(expectedUsername);
  });

  it("adminGetUser throws UserNotFoundException for unknown user", async () => {
    // Arrange
    const pool = await provider.createUserPool("err-pool");
    const expectedError = "UserNotFoundException";

    // Act
    const actualFn = () => provider.adminGetUser(pool.UserPool["Id"] as string, "ghost");

    // Assert
    expect(actualFn).toThrow(expectedError);
  });

  it("initiateAuth returns tokens for valid credentials", async () => {
    // Arrange
    const pool = await provider.createUserPool("auth-pool");
    const poolId = pool.UserPool["Id"] as string;
    const client = provider.createUserPoolClient(poolId, "auth-client");
    const clientId = client.UserPoolClient["ClientId"] as string;
    provider.adminCreateUser(poolId, "bob", "Pass1!");

    // Act
    const actual = await provider.initiateAuth(clientId, "USER_PASSWORD_AUTH", {
      USERNAME: "bob",
      PASSWORD: "Pass1!",
    });

    // Assert
    const expectedTokenType = "string";
    const expectedExpiresIn = 3600;
    expect(typeof actual.AuthenticationResult["AccessToken"]).toBe(expectedTokenType);
    expect(typeof actual.AuthenticationResult["IdToken"]).toBe(expectedTokenType);
    expect(actual.AuthenticationResult["ExpiresIn"]).toBe(expectedExpiresIn);
  });

  it("initiateAuth throws NotAuthorizedException for wrong password", async () => {
    // Arrange
    const pool = await provider.createUserPool("bad-auth-pool");
    const poolId = pool.UserPool["Id"] as string;
    const client = provider.createUserPoolClient(poolId, "bad-client");
    const clientId = client.UserPoolClient["ClientId"] as string;
    provider.adminCreateUser(poolId, "carol", "CorrectPass!");
    const expectedError = "NotAuthorizedException";

    // Act
    const actualFn = () =>
      provider.initiateAuth(clientId, "USER_PASSWORD_AUTH", {
        USERNAME: "carol",
        PASSWORD: "WrongPass!",
      });

    // Assert
    await expect(actualFn()).rejects.toThrow(expectedError);
  });

  it("getUser decodes access token and returns username", async () => {
    // Arrange
    const pool = await provider.createUserPool("get-user-pool");
    const poolId = pool.UserPool["Id"] as string;
    const client = provider.createUserPoolClient(poolId, "get-client");
    const clientId = client.UserPoolClient["ClientId"] as string;
    provider.adminCreateUser(poolId, "dave", "Pass1!");
    const auth = await provider.initiateAuth(clientId, "USER_PASSWORD_AUTH", {
      USERNAME: "dave",
      PASSWORD: "Pass1!",
    });
    const expectedUsername = "dave";

    // Act
    const actual = provider.getUser(auth.AuthenticationResult["AccessToken"] as string);

    // Assert
    expect(actual["Username"]).toBe(expectedUsername);
  });

  it("signUp creates a confirmed user", async () => {
    // Arrange
    const pool = await provider.createUserPool("signup-pool");
    const poolId = pool.UserPool["Id"] as string;
    const client = provider.createUserPoolClient(poolId, "signup-client");
    const clientId = client.UserPoolClient["ClientId"] as string;
    const expectedConfirmed = true;

    // Act
    const actual = provider.signUp(clientId, "eve", "Pass1!");

    // Assert
    const expectedUserSubType = "string";
    expect(actual.UserConfirmed).toBe(expectedConfirmed);
    expect(typeof actual.UserSub).toBe(expectedUserSubType);
  });

  it("reset clears dynamic pools and users from pre-configured pools", async () => {
    // Arrange
    const staticProvider = new CognitoProvider([{ poolName: "static-pool" }]);
    await staticProvider.start();
    await staticProvider.createUserPool("dynamic-pool");
    const staticPoolId = staticProvider.listUserPools().UserPools.find((p) => p["Name"] === "static-pool")!["Id"] as string;
    staticProvider.adminCreateUser(staticPoolId, "user1", "Pass!");
    const expectedDynamicAbsent = "dynamic-pool";
    const expectedStaticPresent = "static-pool";

    // Act
    await staticProvider.reset();

    // Assert
    const actualPools = staticProvider.listUserPools().UserPools.map((p) => p["Name"]);
    expect(actualPools).toContain(expectedStaticPresent);
    expect(actualPools).not.toContain(expectedDynamicAbsent);
    const actualUsers = staticProvider.listUsers(staticPoolId);
    expect(actualUsers.Users).toHaveLength(0);

    await staticProvider.stop();
  });
});
