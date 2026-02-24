import { spawn } from "child_process";
import * as fs from "fs";
import * as os from "os";
import * as path from "path";
import { LwsSession } from "../../src/session";

jest.mock("child_process", () => ({
  spawn: jest.fn(),
}));

const fakeSpawn = spawn as jest.Mock;

function makeFakeProcess() {
  return {
    on: jest.fn(),
    kill: jest.fn(),
    once: jest.fn((_event: string, cb: () => void) => cb()),
    stdout: null,
    stderr: null,
  };
}

describe("LwsSession", () => {
  let fakeProcess: ReturnType<typeof makeFakeProcess>;

  beforeEach(() => {
    jest.useFakeTimers();
    fakeProcess = makeFakeProcess();
    fakeSpawn.mockReturnValue(fakeProcess);
    global.fetch = jest.fn().mockResolvedValue({ ok: true });
  });

  afterEach(() => {
    jest.useRealTimers();
    jest.clearAllMocks();
  });

  describe("create", () => {
    it("spawns ldk dev with the project directory and base port arguments", async () => {
      // Arrange / Act
      const session = await LwsSession.create({});

      // Assert
      expect(fakeSpawn).toHaveBeenCalledWith(
        "ldk",
        expect.arrayContaining([
          "dev",
          "--project-dir",
          expect.any(String),
          "--port",
          expect.any(String),
        ]),
        expect.any(Object)
      );

      await session.close();
    });

    it("spawns without a --mode flag when using explicit spec", async () => {
      // Arrange / Act
      const session = await LwsSession.create({});

      // Assert
      const actualArgs: string[] = fakeSpawn.mock.calls[0][1];
      expect(actualArgs).not.toContain("--mode");

      await session.close();
    });
  });

  describe("fromCdk", () => {
    it("spawns ldk dev with --mode cdk", async () => {
      // Arrange / Act
      const session = await LwsSession.fromCdk("/some/project");

      // Assert
      const actualArgs: string[] = fakeSpawn.mock.calls[0][1];
      expect(actualArgs).toContain("--mode");
      expect(actualArgs).toContain("cdk");

      await session.close();
    });
  });

  describe("fromHcl", () => {
    it("parses HCL files and spawns ldk dev without --mode flag", async () => {
      // Arrange — create a temporary directory with a minimal .tf file (no resources)
      const expectedTmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "lws-test-hcl-"));
      fs.writeFileSync(
        path.join(expectedTmpDir, "main.tf"),
        'provider "aws" { region = "us-east-1" }\n'
      );

      try {
        // Act
        const session = await LwsSession.fromHcl(expectedTmpDir);

        // Assert — ldk is spawned without --mode terraform (mode is auto-detected)
        const actualArgs: string[] = fakeSpawn.mock.calls[0][1];
        expect(actualArgs).toContain("dev");
        expect(actualArgs).not.toContain("terraform");

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
        ].join("\n")
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
              "CreateStateMachine"
            )
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
        "dynamodb", "sqs", "s3", "sns", "stepfunctions", "ssm", "secretsmanager",
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
        '"unsupported-service" is not supported'
      );

      await session.close();
    });
  });

  describe("close", () => {
    it("sends SIGTERM to the ldk process", async () => {
      // Arrange
      const session = await LwsSession.create({});

      // Act
      await session.close();

      // Assert
      expect(fakeProcess.kill).toHaveBeenCalledWith("SIGTERM");
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
