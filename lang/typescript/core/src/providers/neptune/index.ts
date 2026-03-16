/** Neptune wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface DBCluster {
  DBClusterIdentifier: string;
  Status: string;
  Engine: string;
  Endpoint: string;
  ReaderEndpoint: string;
  Port: number;
  DBClusterArn: string;
  DBClusterMembers: DBClusterMember[];
}

interface DBClusterMember {
  DBInstanceIdentifier: string;
  IsClusterWriter: boolean;
  DBClusterParameterGroupStatus: string;
}

interface DBInstance {
  DBInstanceIdentifier: string;
  DBClusterIdentifier: string;
  DBInstanceClass: string;
  Engine: string;
  DBInstanceStatus: string;
  Endpoint: { Address: string; Port: number };
  DBInstanceArn: string;
}

interface DBClusterSnapshot {
  DBClusterSnapshotIdentifier: string;
  DBClusterIdentifier: string;
  Status: string;
  Engine: string;
  SnapshotCreateTime: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
}

export function registerNeptune(app: FastifyInstance, state: ServerState): void {
  const clusters = new Map<string, DBCluster>();
  const instances = new Map<string, DBInstance>();
  const snapshots = new Map<string, DBClusterSnapshot>();

  state.resetCallbacks.push(() => {
    clusters.clear();
    instances.clear();
    snapshots.clear();
  });

  app.addContentTypeParser(
    "application/x-www-form-urlencoded",
    { parseAs: "string" },
    (_req, body, done) => done(null, body)
  );

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = new URLSearchParams(req.body as string);
    const action = params.get("Action") ?? "";
    const ctx = createRequestContext("neptune", action);

    if (await applyIamAuth(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyChaos(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyFake(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }

    switch (action) {
      case "CreateDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster: DBCluster = {
          DBClusterIdentifier: id,
          Status: "available",
          Engine: "neptune",
          Endpoint: `${id}.cluster.neptune.localhost`,
          ReaderEndpoint: `${id}.cluster-ro.neptune.localhost`,
          Port: 8182,
          DBClusterArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:cluster:${id}`,
          DBClusterMembers: [],
        };
        clusters.set(id, cluster);
        jsonReply(reply, { DBCluster: cluster });
        break;
      }

      case "DeleteDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        clusters.delete(id);
        jsonReply(reply, { DBCluster: cluster ?? {} });
        break;
      }

      case "DescribeDBClusters": {
        const filterId = params.get("DBClusterIdentifier");
        let list = Array.from(clusters.values());
        if (filterId) list = list.filter((c) => c.DBClusterIdentifier === filterId);
        jsonReply(reply, { DBClusters: list });
        break;
      }

      case "CreateDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const clusterId = params.get("DBClusterIdentifier") ?? "";
        const instance: DBInstance = {
          DBInstanceIdentifier: id,
          DBClusterIdentifier: clusterId,
          DBInstanceClass: params.get("DBInstanceClass") ?? "db.r5.large",
          Engine: "neptune",
          DBInstanceStatus: "available",
          Endpoint: { Address: `${id}.neptune.localhost`, Port: 8182 },
          DBInstanceArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:db:${id}`,
        };
        instances.set(id, instance);
        const cluster = clusters.get(clusterId);
        if (cluster) {
          cluster.DBClusterMembers.push({
            DBInstanceIdentifier: id,
            IsClusterWriter: cluster.DBClusterMembers.length === 0,
            DBClusterParameterGroupStatus: "in-sync",
          });
        }
        jsonReply(reply, { DBInstance: instance }, 201);
        break;
      }

      case "DeleteDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        instances.delete(id);
        jsonReply(reply, { DBInstance: instance ?? {} });
        break;
      }

      case "DescribeDBInstances": {
        const filterId = params.get("DBInstanceIdentifier");
        let list = Array.from(instances.values());
        if (filterId) list = list.filter((i) => i.DBInstanceIdentifier === filterId);
        jsonReply(reply, { DBInstances: list });
        break;
      }

      case "CreateDBClusterSnapshot": {
        const snapId = params.get("DBClusterSnapshotIdentifier") ?? "";
        const clusterId = params.get("DBClusterIdentifier") ?? "";
        const snap: DBClusterSnapshot = {
          DBClusterSnapshotIdentifier: snapId,
          DBClusterIdentifier: clusterId,
          Status: "available",
          Engine: "neptune",
          SnapshotCreateTime: new Date().toISOString(),
        };
        snapshots.set(snapId, snap);
        jsonReply(reply, { DBClusterSnapshot: snap }, 201);
        break;
      }

      case "DeleteDBClusterSnapshot": {
        const snapId = params.get("DBClusterSnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        snapshots.delete(snapId);
        jsonReply(reply, { DBClusterSnapshot: snap ?? {} });
        break;
      }

      case "DescribeDBClusterSnapshots": {
        const filterId = params.get("DBClusterSnapshotIdentifier");
        let list = Array.from(snapshots.values());
        if (filterId) list = list.filter((s) => s.DBClusterSnapshotIdentifier === filterId);
        jsonReply(reply, { DBClusterSnapshots: list });
        break;
      }

      default: {
        jsonReply(reply, {
          __type: "UnknownOperationException",
          message: `lws: Neptune action '${action}' is not yet implemented`,
        }, 400);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
