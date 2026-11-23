import { describe, it, expect } from "vitest";
import { IamBuilder } from "../../src/builders/iam.js";

describe("IamBuilder.build()", () => {
  it("defaults to disabled mode with admin identity", () => {
    // Arrange
    const expectedMode = "disabled";
    const expectedDefaultIdentity = "admin";
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    const actualConfig = builder.build();

    // Assert
    expect(actualConfig.mode).toBe(expectedMode);
    expect(actualConfig.default_identity).toBe(expectedDefaultIdentity);
    expect(actualConfig.identities).toEqual({});
  });

  it("mode sets the IAM mode", () => {
    // Arrange
    const expectedMode = "enforce";
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    const actualConfig = builder.mode(expectedMode).build();

    // Assert
    expect(actualConfig.mode).toBe(expectedMode);
  });

  it("defaultIdentity sets the default identity name", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");
    const expectedIdentity = "service-role";

    // Act
    const actualConfig = builder.defaultIdentity(expectedIdentity).build();

    // Assert
    expect(actualConfig.default_identity).toBe(expectedIdentity);
  });

  it("identity with allow produces Allow inline policy", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");
    const expectedActions = ["sqs:SendMessage", "sqs:ReceiveMessage"];

    // Act
    builder.identity("sender").allow(expectedActions).done();
    const actualConfig = builder.build();

    // Assert
    const actualPolicy = actualConfig.identities["sender"];
    expect(actualPolicy?.inline_policies).toHaveLength(1);
    expect(actualPolicy?.inline_policies[0]).toEqual({ actions: expectedActions, effect: "Allow" });
  });

  it("identity with deny produces Deny inline policy", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    builder.identity("restricted").deny(["sqs:DeleteQueue"]).done();
    const actualConfig = builder.build();

    // Assert
    const expectedEffect = "Deny";
    const actualPolicy = actualConfig.identities["restricted"];
    expect(actualPolicy?.inline_policies[0]?.effect).toBe(expectedEffect);
  });

  it("identity with boundary produces boundary_policy", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");
    const expectedBoundary = ["sqs:*"];

    // Act
    builder.identity("bounded").boundary(expectedBoundary).done();
    const actualConfig = builder.build();

    // Assert
    expect(actualConfig.identities["bounded"]?.boundary_policy).toEqual({ actions: expectedBoundary });
  });

  it("multiple identities are all included in the config", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    builder.identity("sender").allow(["sqs:SendMessage"]).done();
    builder.identity("receiver").allow(["sqs:ReceiveMessage"]).done();
    const actualConfig = builder.build();

    // Assert
    expect(Object.keys(actualConfig.identities)).toHaveLength(2);
    expect(actualConfig.identities["sender"]).toBeDefined();
    expect(actualConfig.identities["receiver"]).toBeDefined();
  });

  it("done() returns the parent IamBuilder", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    const actualParent = builder.identity("x").done();

    // Assert
    expect(actualParent).toBe(builder);
  });

  it("mode is chainable", () => {
    // Arrange
    const builder = new IamBuilder("http://localhost:9999");

    // Act
    const actualResult = builder.mode("audit");

    // Assert
    expect(actualResult).toBe(builder);
  });
});
