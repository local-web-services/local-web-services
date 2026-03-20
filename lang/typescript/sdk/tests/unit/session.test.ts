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
      expect(mockStartServer).toHaveBeenCalledWith(
        expect.objectContaining({ basePort: expect.any(Number) }),
      );

      await session.close();
    });

    it("starts the server once per session", async () => {
      // Arrange / Act
      const session = await LwsSession.create({});

      // Assert
      expect(mockStartServer).toHaveBeenCalledTimes(1);

      await session.close();
    });
  });

  describe("fromCdk", () => {
    it("starts the in-process server", async () => {
      // Arrange / Act
      const session = await LwsSession.fromCdk("/some/project");

      // Assert
      expect(mockStartServer).toHaveBeenCalledTimes(1);

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
        expect(mockStartServer).toHaveBeenCalledTimes(1);

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
        expect(sfnCall).toBeDefined();
        const actualBody = JSON.parse((sfnCall![1] as Record<string, string>).body);
        expect(actualBody.name).toBe("MySm");

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
        expect(typeof session.portFor(svc)).toBe("number");
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
      expect(s3Port - dynamoPort).toBe(2);

      await session.close();
    });

    it("throws for an unknown service name", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(() => session.portFor("unsupported-service")).toThrow("Unknown service");

      await session.close();
    });
  });

  describe("client", () => {
    it("throws for a service name that has no SDK client implementation", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(() => session.client("unsupported-service")).toThrow(
        '"unsupported-service" is not supported',
      );

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
      expect(mockServerClose).toHaveBeenCalledTimes(1);
    });

    it("is idempotent — a second close does not throw", async () => {
      // Arrange
      const session = await LwsSession.create({});
      await session.close();

      // Act & Assert
      await expect(session.close()).resolves.toBeUndefined();
    });
  });

  describe("_patchEnv / _restoreEnv", () => {
    it("sets AWS_ENDPOINT_URL_DYNAMODB while the session is active", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act
      const actual = process.env.AWS_ENDPOINT_URL_DYNAMODB;

      // Assert
      expect(actual).toMatch(/^http:\/\/127\.0\.0\.1:\d+$/);

      await session.close();
    });

    it("restores AWS_ENDPOINT_URL_DYNAMODB after the session closes", async () => {
      // Arrange
      const expectedBefore = process.env.AWS_ENDPOINT_URL_DYNAMODB;
      const session = await LwsSession.create({});

      // Act
      await session.close();

      // Assert
      expect(process.env.AWS_ENDPOINT_URL_DYNAMODB).toBe(expectedBefore);
    });

    it("sets test credentials while the session is active", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act & Assert
      expect(process.env.AWS_ACCESS_KEY_ID).toBe("test");
      expect(process.env.AWS_SECRET_ACCESS_KEY).toBe("test");
      expect(process.env.AWS_DEFAULT_REGION).toBe("us-east-1");

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
      expect(actual).toBeDefined();

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
      expect(actualEntries).toEqual(expectedEntries);

      await session.close();
    });

    it("returns an empty array when the endpoint responds with a non-ok status", async () => {
      // Arrange
      (global.fetch as jest.Mock).mockResolvedValueOnce({ ok: false });
      const session = await LwsSession.create({});

      // Act
      const actualEntries = await session.recentLogs();

      // Assert
      expect(actualEntries).toEqual([]);

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
      expect(actual._spec.parameters).toEqual([{ name: expectedName }]);
    });
  });

  describe("secret", () => {
    it("returns a resource with the correct spec shape for a Secrets Manager secret", () => {
      // Arrange
      const expectedName = "my-app-secret";

      // Act
      const actual = secret(expectedName);

      // Assert
      expect(actual._spec.secrets).toEqual([{ name: expectedName }]);
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
      expect(actual).toContain("127.0.0.1");
      expect(actual).toContain(expectedQueueName);
      expect(actual).toContain("000000000000");

      await session.close();
    });
  });
});
