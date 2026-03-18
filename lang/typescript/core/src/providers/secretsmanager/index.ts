/** SecretsManager wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface Secret {
  name: string;
  arn: string;
  secretString?: string;
  secretBinary?: string;
  description?: string;
  versionId: string;
  createdDate: number;
  lastChangedDate: number;
  deletedDate?: number;
  tags: Record<string, string>;
}

export class SecretsManagerStore {
  private secrets: Map<string, Secret> = new Map();

  reset(): void {
    this.secrets.clear();
  }

  createSecret(
    name: string,
    secretString?: string,
    secretBinary?: string,
    description?: string,
  ): Secret {
    const existing = this.secrets.get(name);
    if (existing && existing.deletedDate === undefined) {
      throw new Error(
        `ResourceExistsException: A resource with the ID you requested already exists.`,
      );
    }
    const now = Date.now() / 1000;
    const secret: Secret = {
      name,
      arn: `arn:aws:secretsmanager:${REGION}:${ACCOUNT_ID}:secret:${name}`,
      secretString,
      secretBinary,
      description,
      versionId: uuidv4(),
      createdDate: now,
      lastChangedDate: now,
      tags: {},
    };
    this.secrets.set(name, secret);
    return secret;
  }

  getSecret(secretId: string): Secret | undefined {
    const s =
      this.secrets.get(secretId) ??
      Array.from(this.secrets.values()).find((s) => s.arn === secretId);
    // Treat deleted secrets as not found (like real AWS behavior)
    if (s?.deletedDate !== undefined) return undefined;
    return s;
  }

  getSecretIncludingDeleted(secretId: string): Secret | undefined {
    return (
      this.secrets.get(secretId) ??
      Array.from(this.secrets.values()).find((s) => s.arn === secretId)
    );
  }

  putSecretValue(secretId: string, secretString?: string, secretBinary?: string): Secret {
    const secret = this.getSecret(secretId);
    if (!secret) {
      throw new Error(
        `ResourceNotFoundException: Secrets Manager can't find the specified secret.`,
      );
    }
    secret.secretString = secretString ?? secret.secretString;
    secret.secretBinary = secretBinary ?? secret.secretBinary;
    secret.versionId = uuidv4();
    secret.lastChangedDate = Date.now() / 1000;
    return secret;
  }

  updateSecret(
    secretId: string,
    secretString?: string,
    secretBinary?: string,
    description?: string,
  ): Secret {
    const secret = this.getSecret(secretId);
    if (!secret) throw new Error(`ResourceNotFoundException: Secret ${secretId} not found`);
    if (secretString !== undefined) secret.secretString = secretString;
    if (secretBinary !== undefined) secret.secretBinary = secretBinary;
    if (description !== undefined) secret.description = description;
    secret.versionId = uuidv4();
    secret.lastChangedDate = Date.now() / 1000;
    return secret;
  }

  restoreSecret(secretId: string): Secret {
    const secret = this.getSecretIncludingDeleted(secretId);
    if (!secret)
      throw new Error(
        `ResourceNotFoundException: Secrets Manager can't find the specified secret.`,
      );
    if (secret.deletedDate === undefined) {
      throw new Error(
        `InvalidRequestException: You can't restore a secret that isn't scheduled for deletion.`,
      );
    }
    // Recovery window: simulate that if deletedDate is set, window is still open (we never auto-close it in tests)
    delete secret.deletedDate;
    return secret;
  }

  addTags(secretId: string, tags: Array<{ Key: string; Value: string }>): void {
    const secret = this.getSecret(secretId);
    if (!secret)
      throw new Error(
        `ResourceNotFoundException: Secrets Manager can't find the specified secret.`,
      );
    for (const tag of tags) secret.tags[tag.Key] = tag.Value;
  }

  removeTags(secretId: string, tagKeys: string[]): void {
    const secret = this.getSecret(secretId);
    if (!secret)
      throw new Error(
        `ResourceNotFoundException: Secrets Manager can't find the specified secret.`,
      );
    for (const key of tagKeys) delete secret.tags[key];
  }

  listSecretVersionIds(secretId: string): Array<Record<string, unknown>> {
    const secret = this.getSecret(secretId);
    if (!secret) throw new Error(`ResourceNotFoundException: Secret ${secretId} not found`);
    return [
      {
        VersionId: secret.versionId,
        VersionStages: ["AWSCURRENT"],
        CreatedDate: secret.createdDate,
      },
    ];
  }

  deleteSecret(secretId: string, forceDelete = false): void {
    const secret = this.getSecret(secretId);
    if (!secret)
      throw new Error(
        `ResourceNotFoundException: Secrets Manager can't find the specified secret.`,
      );
    if (forceDelete) {
      this.secrets.delete(secret.name);
    } else {
      secret.deletedDate = Date.now() / 1000;
    }
  }

  listSecrets(): Secret[] {
    return Array.from(this.secrets.values());
  }
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

const TARGET_PREFIX = "secretsmanager.";

export function registerSecretsManager(
  app: FastifyInstance,
  state: ServerState,
): SecretsManagerStore {
  const store = new SecretsManagerStore();
  state.resetCallbacks.push(() => store.reset());

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("secretsmanager", operation);

    if (await applyIamAuth(state, "secretsmanager", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "secretsmanager", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "secretsmanager", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      handleOperation(operation, body, store, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.includes("ResourceNotFoundException")) {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
      } else if (msg.includes("ResourceExistsException")) {
        jsonReply(reply, { __type: "ResourceExistsException", message: msg }, 400);
      } else {
        jsonReply(reply, { __type: "InvalidRequestException", message: msg }, 400);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

function handleOperation(
  operation: string,
  body: Record<string, unknown>,
  store: SecretsManagerStore,
  reply: FastifyReply,
): void {
  switch (operation) {
    case "CreateSecret": {
      const secret = store.createSecret(
        body.Name as string,
        body.SecretString as string | undefined,
        body.SecretBinary as string | undefined,
        body.Description as string | undefined,
      );
      jsonReply(reply, {
        ARN: secret.arn,
        Name: secret.name,
        VersionId: secret.versionId,
      });
      break;
    }

    case "GetSecretValue": {
      const secretIncDeleted = store.getSecretIncludingDeleted(body.SecretId as string);
      if (!secretIncDeleted) {
        jsonReply(
          reply,
          {
            __type: "ResourceNotFoundException",
            message: "Secrets Manager can't find the specified secret.",
          },
          400,
        );
        return;
      }
      if (secretIncDeleted.deletedDate !== undefined) {
        jsonReply(
          reply,
          {
            __type: "InvalidRequestException",
            message:
              "You can't perform this operation on the secret because it was marked for deletion.",
          },
          400,
        );
        return;
      }
      const secret = secretIncDeleted;
      const result: Record<string, unknown> = {
        ARN: secret.arn,
        Name: secret.name,
        VersionId: secret.versionId,
        CreatedDate: secret.createdDate,
      };
      if (secret.secretString !== undefined) result.SecretString = secret.secretString;
      if (secret.secretBinary !== undefined) result.SecretBinary = secret.secretBinary;
      jsonReply(reply, result);
      break;
    }

    case "PutSecretValue": {
      const secret = store.putSecretValue(
        body.SecretId as string,
        body.SecretString as string | undefined,
        body.SecretBinary as string | undefined,
      );
      jsonReply(reply, {
        ARN: secret.arn,
        Name: secret.name,
        VersionId: secret.versionId,
      });
      break;
    }

    case "UpdateSecret": {
      const secret = store.updateSecret(
        body.SecretId as string,
        body.SecretString as string | undefined,
        body.SecretBinary as string | undefined,
        body.Description as string | undefined,
      );
      jsonReply(reply, { ARN: secret.arn, Name: secret.name, VersionId: secret.versionId });
      break;
    }

    case "DeleteSecret": {
      const forceDelete = !!body.ForceDeleteWithoutRecovery;
      store.deleteSecret(body.SecretId as string, forceDelete);
      jsonReply(reply, {});
      break;
    }

    case "ListSecrets": {
      const secrets = store.listSecrets();
      jsonReply(reply, {
        SecretList: secrets.map((s) => ({
          ARN: s.arn,
          Name: s.name,
          Description: s.description,
          LastChangedDate: s.lastChangedDate,
          CreatedDate: s.createdDate,
        })),
      });
      break;
    }

    case "DescribeSecret": {
      const secret = store.getSecret(body.SecretId as string);
      if (!secret) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Secret ${body.SecretId} not found` },
          400,
        );
        return;
      }
      jsonReply(reply, {
        ARN: secret.arn,
        Name: secret.name,
        Description: secret.description,
        LastChangedDate: secret.lastChangedDate,
        CreatedDate: secret.createdDate,
        Tags: Object.entries(secret.tags).map(([Key, Value]) => ({ Key, Value })),
      });
      break;
    }

    case "TagResource": {
      const tags = (body.Tags as Array<{ Key: string; Value: string }>) ?? [];
      store.addTags(body.SecretId as string, tags);
      jsonReply(reply, {});
      break;
    }

    case "UntagResource": {
      const tagKeys = (body.TagKeys as string[]) ?? [];
      store.removeTags(body.SecretId as string, tagKeys);
      jsonReply(reply, {});
      break;
    }

    case "RestoreSecret": {
      try {
        const secret = store.restoreSecret(body.SecretId as string);
        jsonReply(reply, { ARN: secret.arn, Name: secret.name });
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        if (msg.includes("InvalidRequestException")) {
          jsonReply(reply, { __type: "InvalidRequestException", message: msg }, 400);
        } else {
          jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
        }
      }
      break;
    }

    case "ListSecretVersionIds": {
      try {
        const versions = store.listSecretVersionIds(body.SecretId as string);
        jsonReply(reply, { Versions: versions });
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        jsonReply(reply, { __type: "ResourceNotFoundException", message: msg }, 400);
      }
      break;
    }

    case "GetResourcePolicy": {
      const secret = store.getSecret(body.SecretId as string);
      if (!secret) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Secret ${body.SecretId} not found` },
          400,
        );
        return;
      }
      jsonReply(reply, { ARN: secret.arn, Name: secret.name, ResourcePolicy: "" });
      break;
    }

    case "PutResourcePolicy":
    case "RotateSecret": {
      jsonReply(reply, {});
      break;
    }

    default: {
      jsonReply(
        reply,
        {
          __type: "UnknownOperationException",
          message: `lws: SecretsManager operation '${operation}' is not yet implemented`,
        },
        400,
      );
    }
  }
}
