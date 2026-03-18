/** S3 Tables wire-protocol Fastify plugin (REST JSON). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface TableBucket {
  arn: string;
  name: string;
  ownerAccountId: string;
  createdAt: string;
}

interface Namespace {
  namespace: string[];
  createdAt: string;
  createdBy: string;
  ownerAccountId: string;
}

interface Table {
  name: string;
  namespace: string[];
  type: string;
  tableARN: string;
  createdAt: string;
  modifiedAt: string;
  ownerAccountId: string;
  warehouseLocation: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
}

export function registerS3Tables(app: FastifyInstance, state: ServerState): void {
  const buckets = new Map<string, TableBucket>();
  // namespace key: `${bucketName}/${namespaceName}`
  const namespaces = new Map<string, Namespace>();
  // table key: `${bucketName}/${namespaceName}/${tableName}`
  const tables = new Map<string, Table>();

  state.resetCallbacks.push(() => {
    buckets.clear();
    namespaces.clear();
    tables.clear();
  });

  // ── Table Buckets ──────────────────────────────────────────────────────────

  app.post("/buckets", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("s3tables", "CreateTableBucket");

    if (await applyIamAuth(state, "s3tables", "CreateTableBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "s3tables", "CreateTableBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3tables", "CreateTableBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const body = req.body as Record<string, unknown>;
    const name = body.name as string;
    const bucket: TableBucket = {
      arn: `arn:aws:s3tables:${REGION}:${ACCOUNT_ID}:bucket/${name}`,
      name,
      ownerAccountId: ACCOUNT_ID,
      createdAt: new Date().toISOString(),
    };
    buckets.set(name, bucket);
    jsonReply(reply, { arn: bucket.arn }, 200);
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete("/buckets/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "DeleteTableBucket");

    if (await applyIamAuth(state, "s3tables", "DeleteTableBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    buckets.delete(bucket);
    reply.status(204).send();
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/buckets", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("s3tables", "ListTableBuckets");

    if (await applyIamAuth(state, "s3tables", "ListTableBuckets", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    jsonReply(reply, { tableBuckets: Array.from(buckets.values()) });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/buckets/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "GetTableBucket");

    if (await applyIamAuth(state, "s3tables", "GetTableBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const b = buckets.get(bucket);
    if (!b) {
      jsonReply(reply, { message: `Bucket ${bucket} not found` }, 404);
    } else {
      jsonReply(reply, b);
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // ── Namespaces ─────────────────────────────────────────────────────────────

  app.post("/buckets/:bucket/namespaces", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "CreateNamespace");

    if (await applyIamAuth(state, "s3tables", "CreateNamespace", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "s3tables", "CreateNamespace", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3tables", "CreateNamespace", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const body = req.body as Record<string, unknown>;
    const namespaceParts = body.namespace as string[];
    const namespaceName = namespaceParts.join(".");
    const ns: Namespace = {
      namespace: namespaceParts,
      createdAt: new Date().toISOString(),
      createdBy: ACCOUNT_ID,
      ownerAccountId: ACCOUNT_ID,
    };
    namespaces.set(`${bucket}/${namespaceName}`, ns);
    jsonReply(reply, {
      tableBucketARN: `arn:aws:s3tables:${REGION}:${ACCOUNT_ID}:bucket/${bucket}`,
      namespace: namespaceParts,
    });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete(
    "/buckets/:bucket/namespaces/:namespace",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { bucket, namespace } = req.params as { bucket: string; namespace: string };
      const ctx = createRequestContext("s3tables", "DeleteNamespace");

      if (await applyIamAuth(state, "s3tables", "DeleteNamespace", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      namespaces.delete(`${bucket}/${namespace}`);
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.get("/buckets/:bucket/namespaces", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "ListNamespaces");

    if (await applyIamAuth(state, "s3tables", "ListNamespaces", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const prefix = `${bucket}/`;
    const list = Array.from(namespaces.entries())
      .filter(([k]) => k.startsWith(prefix))
      .map(([, v]) => v);
    jsonReply(reply, { namespaces: list });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get(
    "/buckets/:bucket/namespaces/:namespace",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { bucket, namespace } = req.params as { bucket: string; namespace: string };
      const ctx = createRequestContext("s3tables", "GetNamespace");

      if (await applyIamAuth(state, "s3tables", "GetNamespace", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const ns = namespaces.get(`${bucket}/${namespace}`);
      if (!ns) {
        jsonReply(reply, { message: `Namespace ${namespace} not found` }, 404);
      } else {
        jsonReply(reply, ns);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // ── Tables ─────────────────────────────────────────────────────────────────

  app.post("/buckets/:bucket/tables", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "CreateTable");

    if (await applyIamAuth(state, "s3tables", "CreateTable", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "s3tables", "CreateTable", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3tables", "CreateTable", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const body = req.body as Record<string, unknown>;
    const name = body.name as string;
    const namespaceParts = body.namespace as string[];
    const namespaceName = namespaceParts.join(".");
    const now = new Date().toISOString();
    const table: Table = {
      name,
      namespace: namespaceParts,
      type: (body.format as string) ?? "ICEBERG",
      tableARN: `arn:aws:s3tables:${REGION}:${ACCOUNT_ID}:bucket/${bucket}/table/${uuidv4()}`,
      createdAt: now,
      modifiedAt: now,
      ownerAccountId: ACCOUNT_ID,
      warehouseLocation: `s3://${bucket}/${namespaceName}/${name}`,
    };
    tables.set(`${bucket}/${namespaceName}/${name}`, table);
    jsonReply(reply, { tableARN: table.tableARN, versionToken: uuidv4() });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete(
    "/buckets/:bucket/tables/:namespace/:table",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { bucket, namespace, table } = req.params as {
        bucket: string;
        namespace: string;
        table: string;
      };
      const ctx = createRequestContext("s3tables", "DeleteTable");

      if (await applyIamAuth(state, "s3tables", "DeleteTable", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      tables.delete(`${bucket}/${namespace}/${table}`);
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.get("/buckets/:bucket/tables", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3tables", "ListTables");

    if (await applyIamAuth(state, "s3tables", "ListTables", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const prefix = `${bucket}/`;
    const list = Array.from(tables.entries())
      .filter(([k]) => k.startsWith(prefix))
      .map(([, v]) => v);
    jsonReply(reply, { tables: list });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get(
    "/buckets/:bucket/tables/:namespace/:table",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { bucket, namespace, table } = req.params as {
        bucket: string;
        namespace: string;
        table: string;
      };
      const ctx = createRequestContext("s3tables", "GetTable");

      if (await applyIamAuth(state, "s3tables", "GetTable", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const t = tables.get(`${bucket}/${namespace}/${table}`);
      if (!t) {
        jsonReply(reply, { message: `Table ${table} not found` }, 404);
      } else {
        jsonReply(reply, t);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );
}
