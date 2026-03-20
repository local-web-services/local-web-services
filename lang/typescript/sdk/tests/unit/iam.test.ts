import { IamBuilder, IdentityBuilder } from "../../src/builders/iam";

describe("IamBuilder", () => {
  beforeEach(() => {
    global.fetch = jest.fn().mockResolvedValue({ ok: true });
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe("IdentityBuilder.boundary", () => {
    it("includes boundary_policy in the applied IAM payload", async () => {
      // Arrange
      const expectedActions = ["dynamodb:GetItem", "dynamodb:PutItem"];
      const expectedResource = "*";
      const builder = new IamBuilder(9000);

      // Act
      builder.identity("test-user").allow(expectedActions).boundary(expectedActions).apply();
      await builder.apply();

      // Assert
      const fetchMock = global.fetch as jest.Mock;
      expect(fetchMock, "Expected fetch to have been called with the IAM endpoint and POST method").toHaveBeenCalledWith(
        "http://127.0.0.1:9000/_ldk/iam-auth",
        expect.objectContaining({ method: "POST" }),
      );
      const actualBody = JSON.parse((fetchMock.mock.calls[0][1] as Record<string, string>).body);
      const actualBoundary = actualBody.identities["test-user"].boundary_policy;
      expect(actualBoundary, "Expected boundary_policy to be defined in the applied payload").toBeDefined();
      expect(actualBoundary.Statement[0].Effect, "Expected the boundary policy statement effect to be Allow").toBe("Allow");
      expect(actualBoundary.Statement[0].Action, "Expected the boundary policy statement actions to match the configured actions").toEqual(expectedActions);
      expect(actualBoundary.Statement[0].Resource, "Expected the boundary policy statement resource to be *").toBe(expectedResource);
    });

    it("returns this for chaining", () => {
      // Arrange
      const builder = new IamBuilder(9000);
      const identityBuilder = builder.identity("test-user") as IdentityBuilder;

      // Act
      const actualResult = identityBuilder.boundary(["dynamodb:GetItem"]);

      // Assert
      expect(actualResult, "Expected boundary() to return the IdentityBuilder instance for chaining").toBe(identityBuilder);
    });
  });
});
