import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { StepFunctionsProvider } from "./provider.js";

export interface StepFunctionsRoutesOptions {
  provider: StepFunctionsProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function stepFunctionsRoutesPlugin(
  fastify: FastifyInstance,
  opts: StepFunctionsRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  const jsonParser = (_req: unknown, body: unknown, done: (err: Error | null, body?: unknown) => void): void => {
    try {
      done(null, JSON.parse(body as string));
    } catch (err) {
      done(err as Error);
    }
  };

  fastify.addContentTypeParser("application/x-amz-json-1.0", { parseAs: "string" }, jsonParser);
  fastify.addContentTypeParser("application/x-amz-json-1.1", { parseAs: "string" }, jsonParser);

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AWSStepFunctions.";
    if (!target.startsWith(prefix)) {
      return reply
        .status(400)
        .header("content-type", "application/x-amz-json-1.1")
        .send(jsonError("InvalidAction", `Unknown target: ${target}`));
    }

    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;
    reply.header("content-type", "application/x-amz-json-1.1");

    try {
      switch (action) {
        case "CreateStateMachine": {
          const result = provider.createStateMachine(
            body["name"] as string,
            body["definition"] as string,
            (body["type"] as "STANDARD" | "EXPRESS" | undefined) ?? "STANDARD",
            body["roleArn"] as string | undefined,
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DeleteStateMachine": {
          provider.deleteStateMachine(body["stateMachineArn"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListStateMachines": {
          const result = provider.listStateMachines();
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DescribeStateMachine": {
          const result = provider.describeStateMachine(body["stateMachineArn"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "StartExecution": {
          const result = provider.startExecution(
            body["stateMachineArn"] as string,
            body["name"] as string | undefined,
            (body["input"] as string | undefined) ?? "{}",
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "StopExecution": {
          const result = provider.stopExecution(
            body["executionArn"] as string,
            body["cause"] as string | undefined,
            body["error"] as string | undefined,
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DescribeExecution": {
          const result = provider.describeExecution(body["executionArn"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "ListExecutions": {
          const result = provider.listExecutions(
            body["stateMachineArn"] as string,
            body["statusFilter"] as string | undefined,
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "GetExecutionHistory": {
          const result = provider.getExecutionHistory(body["executionArn"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "UpdateStateMachine": {
          const result = provider.updateStateMachine(
            body["stateMachineArn"] as string,
            body["definition"] as string | undefined,
            body["roleArn"] as string | undefined,
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "StartSyncExecution": {
          const result = provider.startSyncExecution(
            body["stateMachineArn"] as string,
            body["name"] as string | undefined,
            (body["input"] as string | undefined) ?? "{}",
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "ListStateMachineVersions": {
          return reply.status(200).send(JSON.stringify({ stateMachineVersions: [] }));
        }

        case "ValidateStateMachineDefinition": {
          return reply.status(200).send(JSON.stringify({ result: "OK", diagnostics: [] }));
        }

        case "TagResource": {
          const arn = body["resourceArn"] as string;
          const tags = (body["tags"] as { Key: string; Value: string }[]) ?? [];
          provider.tagResource(arn, tags);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "UntagResource": {
          const arn = body["resourceArn"] as string;
          const keys = (body["tagKeys"] as string[]) ?? [];
          provider.untagResource(arn, keys);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListTagsForResource": {
          const arn = body["resourceArn"] as string;
          const tags = provider.listTagsForResource(arn);
          return reply.status(200).send(JSON.stringify({ Tags: tags }));
        }

        case "CreateActivity": {
          const result = provider.createActivity(body["name"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DeleteActivity": {
          provider.deleteActivity(body["activityArn"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListActivities": {
          return reply.status(200).send(JSON.stringify(provider.listActivities()));
        }

        case "DescribeActivity": {
          const result = provider.describeActivity(body["activityArn"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        default:
          return reply
            .status(400)
            .send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("StateMachineAlreadyExists")) {
        return reply.status(400).send(jsonError("StateMachineAlreadyExists", msg));
      }
      if (msg.startsWith("StateMachineDoesNotExist")) {
        return reply.status(400).send(jsonError("StateMachineDoesNotExist", msg));
      }
      if (msg.startsWith("ExecutionDoesNotExist")) {
        return reply.status(400).send(jsonError("ExecutionDoesNotExist", msg));
      }
      if (msg.startsWith("ExecutionAlreadyExists")) {
        return reply.status(400).send(jsonError("ExecutionAlreadyExists", msg));
      }
      if (msg.startsWith("ActivityAlreadyExists")) {
        return reply.status(400).send(jsonError("ActivityAlreadyExists", msg));
      }
      if (msg.startsWith("ActivityDoesNotExist")) {
        return reply.status(400).send(jsonError("ActivityDoesNotExist", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
