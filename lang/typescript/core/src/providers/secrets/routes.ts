import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { makeLoggingHooks } from "../_shared/logging.js";
import type { SecretsProvider } from "./provider.js";

export interface SecretsRoutesOptions {
  provider: SecretsProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function secretsRoutesPlugin(
  fastify: FastifyInstance,
  opts: SecretsRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  fastify.addContentTypeParser(
    "application/x-amz-json-1.1",
    { parseAs: "string" },
    (_req, body, done) => {
      try {
        done(null, JSON.parse(body as string));
      } catch (err) {
        done(err as Error);
      }
    },
  );

  const { onRequest, onResponse } = makeLoggingHooks("secretsmanager");
  fastify.addHook("onRequest", onRequest);
  fastify.addHook("onResponse", onResponse);

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "secretsmanager.";
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
        case "CreateSecret": {
          const name = body["Name"] as string;
          const secretString = body["SecretString"] as string | undefined;
          const record = provider.createSecret(name, secretString);
          return reply.status(200).send(
            JSON.stringify({ ARN: record.ARN, Name: record.Name, VersionId: record.VersionId }),
          );
        }
        case "GetSecretValue": {
          const id = body["SecretId"] as string;
          const record = provider.getSecretValue(id);
          return reply.status(200).send(JSON.stringify(record));
        }
        case "PutSecretValue": {
          const id = body["SecretId"] as string;
          const secretString = body["SecretString"] as string;
          const record = provider.putSecretValue(id, secretString);
          return reply.status(200).send(
            JSON.stringify({ ARN: record.ARN, Name: record.Name, VersionId: record.VersionId }),
          );
        }
        case "DeleteSecret": {
          const id = body["SecretId"] as string;
          const record = provider.deleteSecret(id);
          return reply.status(200).send(
            JSON.stringify({ ARN: record.ARN, Name: record.Name, DeletionDate: Date.now() / 1000 }),
          );
        }
        case "ListSecrets": {
          const secrets = provider.listSecrets();
          return reply.status(200).send(JSON.stringify({ SecretList: secrets }));
        }
        case "DescribeSecret": {
          const id = body["SecretId"] as string;
          const record = provider.describeSecret(id);
          return reply.status(200).send(JSON.stringify(record));
        }
        case "UpdateSecret": {
          const id = body["SecretId"] as string;
          const secretString = body["SecretString"] as string;
          const record = provider.updateSecret(id, secretString);
          return reply.status(200).send(
            JSON.stringify({ ARN: record.ARN, Name: record.Name, VersionId: record.VersionId }),
          );
        }
        case "RestoreSecret": {
          const id = body["SecretId"] as string;
          const record = provider.restoreSecret(id);
          return reply.status(200).send(JSON.stringify({ ARN: record.ARN, Name: record.Name }));
        }
        case "GetResourcePolicy": {
          const id = body["SecretId"] as string;
          const record = provider.getResourcePolicy(id);
          return reply.status(200).send(
            JSON.stringify({ ARN: record.ARN, Name: record.Name, ResourcePolicy: "" }),
          );
        }
        case "ListSecretVersionIds": {
          const id = body["SecretId"] as string;
          const record = provider.listSecretVersionIds(id);
          return reply.status(200).send(JSON.stringify({
            ARN: record.ARN,
            Name: record.Name,
            Versions: [{ VersionId: record.VersionId, CreatedDate: record.CreatedDate, VersionStages: ["AWSCURRENT"] }],
          }));
        }
        case "TagResource": {
          const arn = body["SecretId"] as string;
          const tags = (body["Tags"] as { Key: string; Value: string }[]) ?? [];
          provider.tagResource(arn, tags);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "UntagResource": {
          const arn = body["SecretId"] as string;
          const keys = (body["TagKeys"] as string[]) ?? [];
          provider.untagResource(arn, keys);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListTagsForResource": {
          const arn = body["SecretId"] as string;
          const tags = provider.listTagsForResource(arn);
          return reply.status(200).send(JSON.stringify({ Tags: tags }));
        }
        default:
          return reply.status(400).send(
            jsonError("InvalidAction", `lws: SecretsManager operation '${action}' is not yet implemented`),
          );
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("ResourceExistsException")) {
        return reply.status(400).send(jsonError("ResourceExistsException", msg));
      }
      if (msg.startsWith("ResourceNotFoundException")) {
        return reply.status(400).send(jsonError("ResourceNotFoundException", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
