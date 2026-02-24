import { IamBuilder, IdentityBuilder } from "../../../src/builders/iam";

const EXPECTED_MGMT_PORT = 8080;
const EXPECTED_IAM_URL = `http://127.0.0.1:${EXPECTED_MGMT_PORT}/_ldk/iam-auth`;

describe("IamBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().fakeResolvedValue({ ok: true });
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.mode).toBe(expectedMode);
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.default_identity).toBe(expectedIdentity);
    });
  });

  describe("apply", () => {
    it("POSTs to the IAM management endpoint", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await builder.apply();

      // Assert
      expect(fakeFetch).toHaveBeenCalledWith(
        EXPECTED_IAM_URL,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
        })
      );
    });

    it("resets state after apply so a second apply sends a clean payload", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);
      await builder.mode("enforce").apply();
      fakeFetch.fakeClear();

      // Act — apply again without setting anything new
      await builder.apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.mode).toBeUndefined();
    });

    it("includes identities in the payload when registered", async () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await builder
        .identity("read-only")
        .allow(["dynamodb:GetItem"])
        .apply()
        .apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      expect(actualBody.identities).toBeDefined();
      expect(actualBody.identities["read-only"]).toBeDefined();
    });
  });

  describe("identity", () => {
    it("returns an IdentityBuilder for the given name", () => {
      // Arrange
      const builder = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      const actual = builder.identity("test-user");

      // Assert
      expect(actual).toBeInstanceOf(IdentityBuilder);
    });
  });
});

describe("IdentityBuilder", () => {
  let fakeFetch: jest.Mock;

  beforeEach(() => {
    fakeFetch = jest.fn().fakeResolvedValue({ ok: true });
    global.fetch = fakeFetch;
  });

  describe("allow", () => {
    it("creates an Allow statement with the given actions and resource", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedActions = ["dynamodb:GetItem", "dynamodb:PutItem"];
      const expectedResource = "arn:aws:dynamodb:::table/Orders";

      // Act
      await parent
        .identity("dev-user")
        .allow(expectedActions, expectedResource)
        .apply()
        .apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      const actualPolicy = actualBody.identities["dev-user"].inline_policies[0];
      expect(actualPolicy.document.Statement[0].Effect).toBe("Allow");
      expect(actualPolicy.document.Statement[0].Action).toEqual(expectedActions);
      expect(actualPolicy.document.Statement[0].Resource).toBe(expectedResource);
    });

    it("defaults resource to * when not specified", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);

      // Act
      await parent
        .identity("dev-user")
        .allow(["s3:GetObject"])
        .apply()
        .apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      const actualStatement =
        actualBody.identities["dev-user"].inline_policies[0].document.Statement[0];
      expect(actualStatement.Resource).toBe("*");
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
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      const actualPolicies = actualBody.identities["dev-user"].inline_policies;
      expect(actualPolicies).toHaveLength(2);
    });
  });

  describe("deny", () => {
    it("creates a Deny statement with the given actions", async () => {
      // Arrange
      const parent = new IamBuilder(EXPECTED_MGMT_PORT);
      const expectedActions = ["dynamodb:DeleteItem"];

      // Act
      await parent
        .identity("readonly-user")
        .deny(expectedActions)
        .apply()
        .apply();

      // Assert
      const actualBody = JSON.parse(fakeFetch.fake.calls[0][1].body);
      const actualStatement =
        actualBody.identities["readonly-user"].inline_policies[0].document.Statement[0];
      expect(actualStatement.Effect).toBe("Deny");
      expect(actualStatement.Action).toEqual(expectedActions);
    });
  });
});
