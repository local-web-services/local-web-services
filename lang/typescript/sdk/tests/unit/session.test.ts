import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { LwsSession, parameter, secret } from "../../src/session";

// Mock the in-process server so _start() never spawns a real HTTP server.
const mockServerClose = jest.fn().mockResolvedValue(undefined);
const mockServer = { close: mockServerClose };
const mockStartServer = jest.fn().mockResolvedValue(mockServer);

jest.mock("local-web-services-typescript-core", () => ({
  startServer: (...args: unknown[]) => mockStartServer(...args),
}));

describe("LwsSession", () => {
  beforeEach(() => {
    jest.clearAllMocks();
    mockStartServer.mockResolvedValue(mockServer);
    global.fetch = jest.fn().mockResolvedValue({ ok: true });
  });

  describe("create", () => {
    it("starts the in-process server with a base port", async () => {
      // Arrange / Act
      const session = await LwsSession.create({});

      // Assert
      expect(
        mockStartServer,
        "Expected startServer to have been called with a basePort option",
      ).toHaveBeenCalledWith(expect.objectContaining({ basePort: expect.any(Number) }));

      await session.close();
    });

    it("starts the server once per session", async () => {
      // Arrange / Act
      const session = await LwsSession.create({});

      // Assert
      expect(
        mockStartServer,
        "Expected startServer to have been called exactly once per session",
      ).toHaveBeenCalledTimes(1);

      await session.close();
    });
  });

  describe("fromCdk", () => {
    it("starts the in-process server", async () => {
      // Arrange / Act
      const session = await LwsSession.fromCdk("/some/project");

      // Assert
      expect(
        mockStartServer,
        "Expected startServer to have been called once when creating a session from CDK",
      ).toHaveBeenCalledTimes(1);

      await session.close();
    });
  });

  describe("fromHcl", () => {
    it("starts the in-process server without error", async () => {
      // Arrange — create a temporary directory with a minimal .tf file (no resources)
      const expectedTmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "lws-test-hcl-"));
      fs.writeFileSync(
        path.join(expectedTmpDir, "main.tf"),
        'provider "aws" { region = "us-east-1" }\n',
      );

      try {
        // Act
        const session = await LwsSession.fromHcl(expectedTmpDir);

        // Assert
        expect(
          mockStartServer,
          "Expected startServer to have been called once when creating a session from HCL",
        ).toHaveBeenCalledTimes(1);

        await session.close();
      } finally {
        fs.rmSync(expectedTmpDir, { recursive: true });
      }
    });

    it("pre-creates discovered state machines via SFN API", async () => {
      // Arrange — create a temporary directory with a state machine .tf
      const expectedTmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "lws-test-hcl-sm-"));
      const expectedDefinition = JSON.stringify({
        StartAt: "Done",
        States: { Done: { Type: "Pass", End: true } },
      });
      fs.writeFileSync(
        path.join(expectedTmpDir, "main.tf"),
        [
          'resource "aws_sfn_state_machine" "my_sm" {',
          '  name     = "MySm"',
          `  definition = <<EOF`,
          expectedDefinition,
          "EOF",
          "}",
        ].join("\n"),
      );

      try {
        // Act
        const session = await LwsSession.fromHcl(expectedTmpDir);

        // Assert — fetch was called to create the state machine
        const fetchCalls = (global.fetch as jest.Mock).mock.calls;
        const sfnCall = fetchCalls.find(
          (call: unknown[]) =>
            typeof call[1] === "object" &&
            (call[1] as Record<string, unknown>).headers !== undefined &&
            JSON.stringify((call[1] as Record<string, unknown>).headers).includes(
              "CreateStateMachine",
            ),
        );
        expect(
          sfnCall,
          "Expected fetch to have been called to create the state machine discovered in HCL",
        ).toBeDefined();
        const actualBody = JSON.parse((sfnCall![1] as Record<string, string>).body);
        expect(
          actualBody.name,
          "Expected the CreateStateMachine call to use the state machine name from HCL",
        ).toBe("MySm");

        await session.close();
      } finally {
        fs.rmSync(expectedTmpDir, { recursive: true });
      }
    });
  });

  describe("portFor", () => {
    it("returns a number for each known service", async () => {
      // Arrange
      const session = await LwsSession.create({});
      const expectedServices = [
        "dynamodb",
        "sqs",
        "s3",
        "sns",
        "stepfunctions",
        "ssm",
        "secretsmanager",
      ];

      // Act & Assert
      for (const svc of expectedServices) {
        expect(
          typeof session.portFor(svc),
          `Expected portFor to return a number for service "${svc}"`,
        ).toBe("number");
      }

      await session.close();
    });

    it("returns ports that differ by the correct offset between services", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act
      const dynamoPort = session.portFor("dynamodb");
      const s3Port = session.portFor("s3");

      // Assert — dynamodb offset is 1, s3 offset is 3, difference should be 2
      expect(
        s3Port - dynamoPort,
        "Expected the port difference between s3 and dynamodb to be 2 based on their offsets",
      ).toBe(2);

      await session.close();
    });

    it("throws for an unknown service name", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(
        () => session.portFor("unsupported-service"),
        "Expected portFor to throw for an unknown service name",
      ).toThrow("Unknown service");

      await session.close();
    });
  });

  describe("client", () => {
    it("throws for a service name that has no SDK client implementation", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(
        () => session.client("unsupported-service"),
        "Expected client() to throw for a service name that has no SDK client implementation",
      ).toThrow('"unsupported-service" is not supported');

      await session.close();
    });
  });

  describe("close", () => {
    it("stops the in-process server", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act
      await session.close();

      // Assert
      expect(
        mockServerClose,
        "Expected the server close method to have been called once",
      ).toHaveBeenCalledTimes(1);
    });

    it("is idempotent — a second close does not throw", async () => {
      // Arrange
      const session = await LwsSession.create({});
      await session.close();

      // Act & Assert
      await expect(
        session.close(),
        "Expected a second close call to resolve without throwing",
      ).resolves.toBeUndefined();
    });
  });

  describe("_patchEnv / _restoreEnv", () => {
    it("sets AWS_ENDPOINT_URL_DYNAMODB while the session is active", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act
      const actual = process.env.AWS_ENDPOINT_URL_DYNAMODB;

      // Assert
      expect(
        actual,
        "Expected AWS_ENDPOINT_URL_DYNAMODB to be set to a local URL while the session is active",
      ).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);

      await session.close();
    });

    it("restores AWS_ENDPOINT_URL_DYNAMODB after the session closes", async () => {
      // Arrange
      const expectedBefore = process.env.AWS_ENDPOINT_URL_DYNAMODB;
      const session = await LwsSession.create({});

      // Act
      await session.close();

      // Assert
      expect(
        process.env.AWS_ENDPOINT_URL_DYNAMODB,
        "Expected AWS_ENDPOINT_URL_DYNAMODB to be restored to its original value after the session closes",
      ).toBe(expectedBefore);
    });

    it("sets test credentials while the session is active", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(
        process.env.AWS_ACCESS_KEY_ID,
        "Expected AWS_ACCESS_KEY_ID to be set to 'test' while the session is active",
      ).toBe("test");
      expect(
        process.env.AWS_SECRET_ACCESS_KEY,
        "Expected AWS_SECRET_ACCESS_KEY to be set to 'test' while the session is active",
      ).toBe("test");
      expect(
        process.env.AWS_DEFAULT_REGION,
        "Expected AWS_DEFAULT_REGION to be set to 'us-east-1' while the session is active",
      ).toBe("us-east-1");

      await session.close();
    });
  });

  describe("lifecycle", () => {
    it("returns a LifecycleBuilder for the given service", async () => {
      // Arrange
      const session = await LwsSession.create({});
      const expectedService = "dynamodb";

      // Act
      const actual = session.lifecycle(expectedService);

      // Assert
      expect(
        actual,
        "Expected lifecycle() to return a defined LifecycleBuilder for the given service",
      ).toBeDefined();

      await session.close();
    });
  });

  describe("recentLogs", () => {
    it("calls /_ldk/logs/recent and returns parsed log entries", async () => {
      // Arrange
      const expectedEntries = [{ service: "dynamodb", operation: "PutItem", level: "INFO" }];
      (global.fetch as jest.Mock).mockResolvedValueOnce({
        ok: true,
        json: jest.fn().mockResolvedValue(expectedEntries),
      });
      const session = await LwsSession.create({});

      // Act
      const actualEntries = await session.recentLogs();

      // Assert
      expect(
        actualEntries,
        "Expected recentLogs to return the parsed log entries from the endpoint",
      ).toEqual(expectedEntries);

      await session.close();
    });

    it("returns an empty array when the endpoint responds with a non-ok status", async () => {
      // Arrange
      (global.fetch as jest.Mock).mockResolvedValueOnce({ ok: false });
      const session = await LwsSession.create({});

      // Act
      const actualEntries = await session.recentLogs();

      // Assert
      expect(
        actualEntries,
        "Expected recentLogs to return an empty array when the endpoint responds with a non-ok status",
      ).toEqual([]);

      await session.close();
    });
  });

  describe("parameter", () => {
    it("returns a resource with the correct spec shape for an SSM parameter", () => {
      // Arrange
      const expectedName = "/app/config/key";

      // Act
      const actual = parameter(expectedName);

      // Assert
      expect(
        actual._spec.parameters,
        "Expected parameter() to return a resource with the correct SSM parameter spec shape",
      ).toEqual([{ name: expectedName }]);
    });
  });

  describe("secret", () => {
    it("returns a resource with the correct spec shape for a Secrets Manager secret", () => {
      // Arrange
      const expectedName = "my-app-secret";

      // Act
      const actual = secret(expectedName);

      // Assert
      expect(
        actual._spec.secrets,
        "Expected secret() to return a resource with the correct Secrets Manager secret spec shape",
      ).toEqual([{ name: expectedName }]);
    });
  });

  describe("queueUrl", () => {
    it("returns a local URL containing the queue name", async () => {
      // Arrange
      const session = await LwsSession.create({});
      const expectedQueueName = "OrderQueue";

      // Act
      const actual = session.queueUrl(expectedQueueName);

      // Assert
      expect(actual, "Expected queueUrl to contain the local host address").toContain("127.0.0.1");
      expect(actual, "Expected queueUrl to contain the queue name").toContain(expectedQueueName);
      expect(actual, "Expected queueUrl to contain the AWS account ID placeholder").toContain(
        "000000000000",
      );

      await session.close();
    });
  });
});
