import { IamBuilder, IdentityBuilder } from "../../../src/builders/iam";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_IAM_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/iam-auth`;

describe("IamBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("mode", () => {
    it("includes the mode in the applied payload", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedMode = "enforce";

      // Act
      await builder.mode(expectedMode).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.mode, "Expected the IAM payload mode to match the configured mode").toBe(expectedMode);
    });
  });

  describe("defaultIdentity", () => {
    it("includes default_identity in the applied payload", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedIdentity = "admin-user";

      // Act
      await builder.defaultIdentity(expectedIdentity).apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.default_identity, "Expected the IAM payload default_identity to match the configured identity").toBe(expectedIdentity);
    });
  });

  describe("apply", () => {
    it("POSTs to the IAM management endpoint", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await builder.apply();

      // Assert
      expect(fakeFetch, "Expected fetch to have been called with the IAM management URL and correct headers").toHaveBeenCalledWith(
        EXPECTED_IAM_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        }),
      );
    });

    it("resets state after apply so a second apply sends a clean payload", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);
      await builder.mode("enforce").apply();
      fakeFetch.mockClear();

      // Act — apply again without setting anything new
      await builder.apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.mode, "Expected mode to be undefined in the clean payload after state reset").toBeUndefined();
    });

    it("includes identities in the payload when registered", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await builder.identity("read-only").allow(["dynamodb:GetItem"]).apply().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      expect(actualBody.identities, "Expected identities to be defined in the payload").toBeDefined();
      expect(actualBody.identities["read-only"], "Expected the read-only identity to be defined in the payload").toBeDefined();
    });
  });

  describe("identity", () => {
    it("returns an IdentityBuilder for the given name", () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      const actual = builder.identity("test-user");

      // Assert
      expect(actual, "Expected identity() to return an IdentityBuilder instance").toBeInstanceOf(IdentityBuilder);
    });
  });
});

describe("IdentityBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().mockResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("allow", () => {
    it("creates an Allow statement with the given actions and resource", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedActions = ["dynamodb:GetItem", "dynamodb:PutItem"];
      const expectedResource = "arn:aws:dynamodb:::table/Orders";

      // Act
      await parent.identity("dev-user").allow(expectedActions, expectedResource).apply().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualPolicy = actualBody.identities["dev-user"].inline_policies[0];
      expect(actualPolicy.Statement[0].Effect, "Expected the first statement effect to be Allow").toBe("Allow");
      expect(actualPolicy.Statement[0].Action, "Expected the first statement actions to match the configured actions").toEqual(expectedActions);
      expect(actualPolicy.Statement[0].Resource, "Expected the first statement resource to match the configured resource").toBe(expectedResource);
    });

    it("defaults resource to * when not specified", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await parent.identity("dev-user").allow(["s3:GetObject"]).apply().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualStatement = actualBody.identities["dev-user"].inline_policies[0].Statement[0];
      expect(actualStatement.Resource, "Expected the default resource to be * when no resource is specified").toBe("*");
    });

    it("supports method chaining to add multiple allow statements", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await parent
        .identity("dev-user")
        .allow(["dynamodb:GetItem"])
        .allow(["s3:GetObject"])
        .apply()
        .apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualPolicies = actualBody.identities["dev-user"].inline_policies;
      expect(actualPolicies, "Expected two inline policies after chaining two allow calls").toHaveLength(2);
    });
  });

  describe("deny", () => {
    it("creates a Deny statement with the given actions", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedActions = ["dynamodb:DeleteItem"];

      // Act
      await parent.identity("readonly-user").deny(expectedActions).apply().apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.mock.calls[0][1].body);
      const actualStatement =
        actualBody.identities["readonly-user"].inline_policies[0].Statement[0];
      expect(actualStatement.Effect, "Expected the deny statement effect to be Deny").toBe("Deny");
      expect(actualStatement.Action, "Expected the deny statement actions to match the configured actions").toEqual(expectedActions);
    });
  });
});
