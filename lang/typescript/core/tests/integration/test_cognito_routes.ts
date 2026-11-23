import { describe, it, expect, beforeEach, afterEach } from "vitest";
import Fastify from "fastify";
import type { FastifyInstance } from "fastify";
import { CognitoProvider } from "../../src/providers/cognito/provider.js";
import { cognitoRoutesPlugin } from "../../src/providers/cognito/routes.js";

async function buildCognitoApp(): Promise<FastifyInstance> {
  const provider = new CognitoProvider([]);
  await provider.start();
  const app = Fastify({ logger: false });
  await app.register(cognitoRoutesPlugin, { provider });
  await app.ready();
  return app;
}

async function cognitoRequest(
  app: FastifyInstance,
  operation: string,
  payload: Record<string, unknown>,
): Promise<{ status: number; body: Record<string, unknown> }> {
  const response = await app.inject({
    method: "POST",
    url: "/",
    headers: {
      "content-type": "application/x-amz-json-1.1",
      "x-amz-target": `AWSCognitoIdentityProviderService.${operation}`,
    },
    payload: JSON.stringify(payload),
  });
  return { status: response.statusCode, body: JSON.parse(response.body) as Record<string, unknown> };
}

describe("Cognito routes — CreateUserPool / ListUserPools", () => {
  let app: FastifyInstance;

  beforeEach(async () => { app = await buildCognitoApp(); });
  afterEach(async () => { await app.close(); });

  it("CreateUserPool returns a pool Id", async () => {
    // Arrange
    const expectedPoolName = "integration-pool";

    // Act
    const actual = await cognitoRequest(app, "CreateUserPool", { PoolName: expectedPoolName });

    // Assert
    expect(actual.status).toBe(200);
    const pool = (actual.body as Record<string, Record<string, unknown>>)["UserPool"];
    expect(pool["Name"]).toBe(expectedPoolName);
    expect(typeof pool["Id"]).toBe("string");
  });

  it("ListUserPools returns created pool", async () => {
    // Arrange
    const expectedPoolName = "list-integration-pool";
    await cognitoRequest(app, "CreateUserPool", { PoolName: expectedPoolName });

    // Act
    const actual = await cognitoRequest(app, "ListUserPools", {});

    // Assert
    expect(actual.status).toBe(200);
    const pools = (actual.body["UserPools"] as Record<string, unknown>[]);
    const actualNames = pools.map((p) => p["Name"]);
    expect(actualNames).toContain(expectedPoolName);
  });
});

describe("Cognito routes — user management", () => {
  let app: FastifyInstance;
  let poolId: string;

  beforeEach(async () => {
    app = await buildCognitoApp();
    const result = await cognitoRequest(app, "CreateUserPool", { PoolName: "test-pool" });
    poolId = (result.body as Record<string, Record<string, unknown>>)["UserPool"]["Id"] as string;
  });
  afterEach(async () => { await app.close(); });

  it("AdminCreateUser and AdminGetUser round-trip", async () => {
    // Arrange
    const expectedUsername = "integration-user";

    // Act
    await cognitoRequest(app, "AdminCreateUser", {
      UserPoolId: poolId,
      Username: expectedUsername,
      TemporaryPassword: "TempPass1!",
    });
    const actual = await cognitoRequest(app, "AdminGetUser", {
      UserPoolId: poolId,
      Username: expectedUsername,
    });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["Username"]).toBe(expectedUsername);
  });

  it("AdminGetUser returns 400 for unknown user", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actual = await cognitoRequest(app, "AdminGetUser", {
      UserPoolId: poolId,
      Username: "ghost-user",
    });

    // Assert
    expect(actual.status).toBe(expectedStatus);
    expect((actual.body["__type"] as string)).toContain("UserNotFoundException");
  });

  it("ListUsers returns created users", async () => {
    // Arrange
    const expectedUsername = "list-user";
    await cognitoRequest(app, "AdminCreateUser", {
      UserPoolId: poolId,
      Username: expectedUsername,
      TemporaryPassword: "Pass1!",
    });

    // Act
    const actual = await cognitoRequest(app, "ListUsers", { UserPoolId: poolId });

    // Assert
    expect(actual.status).toBe(200);
    const users = (actual.body["Users"] as Record<string, unknown>[]);
    const actualUsernames = users.map((u) => u["Username"]);
    expect(actualUsernames).toContain(expectedUsername);
  });
});

describe("Cognito routes — authentication", () => {
  let app: FastifyInstance;
  let poolId: string;
  let clientId: string;

  beforeEach(async () => {
    app = await buildCognitoApp();
    const poolResult = await cognitoRequest(app, "CreateUserPool", { PoolName: "auth-pool" });
    poolId = (poolResult.body as Record<string, Record<string, unknown>>)["UserPool"]["Id"] as string;
    const clientResult = await cognitoRequest(app, "CreateUserPoolClient", {
      UserPoolId: poolId,
      ClientName: "test-client",
    });
    clientId = (clientResult.body as Record<string, Record<string, unknown>>)["UserPoolClient"]["ClientId"] as string;
    await cognitoRequest(app, "AdminCreateUser", {
      UserPoolId: poolId,
      Username: "auth-user",
      TemporaryPassword: "Pass1!",
    });
  });
  afterEach(async () => { await app.close(); });

  it("InitiateAuth returns AccessToken and IdToken", async () => {
    // Arrange
    const expectedTokenType = "Bearer";

    // Act
    const actual = await cognitoRequest(app, "InitiateAuth", {
      ClientId: clientId,
      AuthFlow: "USER_PASSWORD_AUTH",
      AuthParameters: { USERNAME: "auth-user", PASSWORD: "Pass1!" },
    });

    // Assert
    expect(actual.status).toBe(200);
    const authResult = (actual.body["AuthenticationResult"] as Record<string, unknown>);
    expect(typeof authResult["AccessToken"]).toBe("string");
    expect(typeof authResult["IdToken"]).toBe("string");
    expect(authResult["TokenType"]).toBe(expectedTokenType);
  });

  it("InitiateAuth returns 400 for wrong password", async () => {
    // Arrange
    const expectedStatus = 400;

    // Act
    const actual = await cognitoRequest(app, "InitiateAuth", {
      ClientId: clientId,
      AuthFlow: "USER_PASSWORD_AUTH",
      AuthParameters: { USERNAME: "auth-user", PASSWORD: "WrongPass!" },
    });

    // Assert
    expect(actual.status).toBe(expectedStatus);
    expect((actual.body["__type"] as string)).toContain("NotAuthorizedException");
  });

  it("SignUp creates a user confirmed immediately", async () => {
    // Arrange
    const expectedConfirmed = true;

    // Act
    const actual = await cognitoRequest(app, "SignUp", {
      ClientId: clientId,
      Username: "signup-user",
      Password: "Pass1!",
    });

    // Assert
    expect(actual.status).toBe(200);
    expect(actual.body["UserConfirmed"]).toBe(expectedConfirmed);
  });
});
