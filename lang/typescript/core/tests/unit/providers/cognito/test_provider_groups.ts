import { describe, it, expect, beforeEach } from "vitest";
import { CognitoProvider } from "../../../../src/providers/cognito/provider.js";

describe("CognitoProvider groups", () => {
  let provider: CognitoProvider;
  let poolId: string;

  beforeEach(async () => {
    provider = new CognitoProvider([]);
    await provider.start();
    const pool = await provider.createUserPool("group-pool");
    poolId = pool.UserPool["Id"] as string;
  });

  it("createGroup returns group with GroupName", () => {
    // Arrange
    const expectedGroupName = "admins";

    // Act
    const actual = provider.createGroup(poolId, expectedGroupName, "Admin group");

    // Assert
    expect(actual.Group["GroupName"]).toBe(expectedGroupName);
    expect(actual.Group["UserPoolId"]).toBe(poolId);
  });

  it("listGroups includes created group", () => {
    // Arrange
    const expectedGroupName = "editors";
    provider.createGroup(poolId, expectedGroupName);

    // Act
    const actual = provider.listGroups(poolId);

    // Assert
    const actualNames = actual.Groups.map((g) => g["GroupName"]);
    expect(actualNames).toContain(expectedGroupName);
  });

  it("deleteGroup removes the group", () => {
    // Arrange
    const expectedAbsentGroup = "temp-group";
    provider.createGroup(poolId, expectedAbsentGroup);

    // Act
    provider.deleteGroup(poolId, expectedAbsentGroup);
    const actual = provider.listGroups(poolId);

    // Assert
    const actualNames = actual.Groups.map((g) => g["GroupName"]);
    expect(actualNames).not.toContain(expectedAbsentGroup);
  });

  it("adminAddUserToGroup makes user appear in listUsersInGroup", () => {
    // Arrange
    provider.createGroup(poolId, "members");
    provider.adminCreateUser(poolId, "alice", "Pass1!");
    const expectedUsername = "alice";

    // Act
    provider.adminAddUserToGroup(poolId, expectedUsername, "members");
    const actual = provider.listUsersInGroup(poolId, "members");

    // Assert
    const actualUsernames = actual.Users.map((u) => u["Username"]);
    expect(actualUsernames).toContain(expectedUsername);
  });

  it("adminRemoveUserFromGroup removes user from group", () => {
    // Arrange
    provider.createGroup(poolId, "removals");
    provider.adminCreateUser(poolId, "bob", "Pass1!");
    provider.adminAddUserToGroup(poolId, "bob", "removals");
    const expectedAbsentUsername = "bob";

    // Act
    provider.adminRemoveUserFromGroup(poolId, expectedAbsentUsername, "removals");
    const actual = provider.listUsersInGroup(poolId, "removals");

    // Assert
    const actualUsernames = actual.Users.map((u) => u["Username"]);
    expect(actualUsernames).not.toContain(expectedAbsentUsername);
  });

  it("listUsersInGroup returns empty list when group has no members", () => {
    // Arrange
    provider.createGroup(poolId, "empty-group");
    const expectedCount = 0;

    // Act
    const actual = provider.listUsersInGroup(poolId, "empty-group");

    // Assert
    expect(actual.Users).toHaveLength(expectedCount);
  });
});
