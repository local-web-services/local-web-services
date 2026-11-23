import { describe, it, expect } from "vitest";
import { join } from "path";
import { parseCdkAssembly } from "../../src/cdk.js";
import {
  DynamoTable,
  SqsQueue,
  S3Bucket,
  SnsTopic,
  SsmParameter,
  Secret,
  EventBus,
  StateMachine,
  CognitoUserPool,
  LambdaFunction,
} from "../../src/specs.js";

const fixtureDir = join(import.meta.dirname, "fixtures");
const fixturePath = join(fixtureDir, "template.json");

describe("parseCdkAssembly — direct template file", () => {
  it("extracts a DynamoDB table with hash key", () => {
    // Arrange
    const expectedName = "orders";
    const expectedHashKey = "orderId";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualTable = actual.find((r): r is DynamoTable => r instanceof DynamoTable);

    // Assert
    expect(actualTable).toBeDefined();
    expect(actualTable!.name).toBe(expectedName);
    expect(actualTable!.hashKey).toBe(expectedHashKey);
  });

  it("extracts an SQS queue", () => {
    // Arrange
    const expectedName = "order-queue";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualQueue = actual.find((r): r is SqsQueue => r instanceof SqsQueue);

    // Assert
    expect(actualQueue).toBeDefined();
    expect(actualQueue!.name).toBe(expectedName);
  });

  it("extracts an S3 bucket", () => {
    // Arrange
    const expectedName = "my-assets";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualBucket = actual.find((r): r is S3Bucket => r instanceof S3Bucket);

    // Assert
    expect(actualBucket).toBeDefined();
    expect(actualBucket!.name).toBe(expectedName);
  });

  it("extracts an SNS topic", () => {
    // Arrange
    const expectedName = "order-created";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualTopic = actual.find((r): r is SnsTopic => r instanceof SnsTopic);

    // Assert
    expect(actualTopic).toBeDefined();
    expect(actualTopic!.name).toBe(expectedName);
  });

  it("extracts an SSM parameter", () => {
    // Arrange
    const expectedName = "/app/db-host";
    const expectedValue = "localhost";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualParam = actual.find((r): r is SsmParameter => r instanceof SsmParameter);

    // Assert
    expect(actualParam).toBeDefined();
    expect(actualParam!.name).toBe(expectedName);
    expect(actualParam!.value).toBe(expectedValue);
  });

  it("extracts a Secrets Manager secret", () => {
    // Arrange
    const expectedName = "prod/db/password";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualSecret = actual.find((r): r is Secret => r instanceof Secret);

    // Assert
    expect(actualSecret).toBeDefined();
    expect(actualSecret!.name).toBe(expectedName);
  });

  it("extracts an EventBridge bus", () => {
    // Arrange
    const expectedName = "order-bus";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualBus = actual.find((r): r is EventBus => r instanceof EventBus);

    // Assert
    expect(actualBus).toBeDefined();
    expect(actualBus!.name).toBe(expectedName);
  });

  it("extracts a Step Functions state machine", () => {
    // Arrange
    const expectedName = "order-processor";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualSm = actual.find((r): r is StateMachine => r instanceof StateMachine);

    // Assert
    expect(actualSm).toBeDefined();
    expect(actualSm!.name).toBe(expectedName);
  });

  it("extracts a Cognito user pool", () => {
    // Arrange
    const expectedName = "app-users";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualPool = actual.find((r): r is CognitoUserPool => r instanceof CognitoUserPool);

    // Assert
    expect(actualPool).toBeDefined();
    expect(actualPool!.name).toBe(expectedName);
  });

  it("extracts a Lambda function", () => {
    // Arrange
    const expectedName = "order-handler";
    const expectedHandler = "index.handler";
    const expectedRuntime = "nodejs20.x";

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });
    const actualFn = actual.find((r): r is LambdaFunction => r instanceof LambdaFunction);

    // Assert
    expect(actualFn).toBeDefined();
    expect(actualFn!.name).toBe(expectedName);
    expect(actualFn!.handler).toBe(expectedHandler);
    expect(actualFn!.runtime).toBe(expectedRuntime);
  });

  it("skips unsupported resource types like IAM::Role", () => {
    // Arrange
    const expectedCount = 10;

    // Act
    const actual = parseCdkAssembly({ assemblyPath: fixturePath });

    // Assert
    expect(actual).toHaveLength(expectedCount);
  });
});

describe("parseCdkAssembly — intrinsic resolution", () => {
  it("resolves Fn::Join for a resource name", () => {
    // Arrange
    const expectedName = "prefix-suffix";

    // Act
    const actual = parseCdkAssembly({
      assemblyPath: join(fixtureDir, "template_intrinsics.json"),
    });
    const actualBucket = actual.find((r): r is S3Bucket => r instanceof S3Bucket);

    // Assert
    expect(actualBucket).toBeDefined();
    expect(actualBucket!.name).toBe(expectedName);
  });

  it("falls back to Ref logical ID when Ref is used as a name", () => {
    // Arrange
    const expectedName = "BucketNameParam";

    // Act
    const actual = parseCdkAssembly({
      assemblyPath: join(fixtureDir, "template_intrinsics.json"),
    });
    const actualQueue = actual.find((r): r is SqsQueue => r instanceof SqsQueue);

    // Assert
    expect(actualQueue).toBeDefined();
    expect(actualQueue!.name).toBe(expectedName);
  });
});

describe("parseCdkAssembly — assembly directory", () => {
  it("throws when cdk.out/manifest.json is not found", () => {
    // Arrange
    const expectedErrorFragment = "CDK manifest not found";

    // Act
    const actual = (): void => { parseCdkAssembly({ assemblyPath: fixtureDir }); };

    // Assert
    expect(actual).toThrow(expectedErrorFragment);
  });
});
