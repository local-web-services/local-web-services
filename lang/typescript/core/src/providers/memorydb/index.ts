/** MemoryDB wire-protocol Fastify plugin (JSON protocol, X-Amz-Target). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface Cluster {
  Name: string;
  Status: string;
  NumberOfShards: number;
  AvailabilityMode: string;
  ClusterEndpoint: { Address: string; Port: number };
  NodeType: string;
  EngineVersion: string;
  ARN: string;
  ACLName: string;
}

interface MemoryDBUser {
  Name: string;
  Status: string;
  AccessString: string;
  ARN: string;
  ACLNames: string[];
}

interface ACL {
  Name: string;
  Status: string;
  UserNames: string[];
  ARN: string;
}

interface Snapshot {
  Name: string;
  Status: string;
  ClusterConfiguration: { Name: string };
  ARN: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

const TARGET_PREFIX = "AmazonMemoryDB.";

export function registerMemoryDb(app: FastifyInstance, state: ServerState): void {
  const clusters = new Map<string, Cluster>();
  const users = new Map<string, MemoryDBUser>();
  const acls = new Map<string, ACL>();
  const snapshots = new Map<string, Snapshot>();

  state.resetCallbacks.push(() => {
    clusters.clear();
    users.clear();
    acls.clear();
    snapshots.clear();
  });

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("memorydb", operation);

    if (await applyIamAuth(state, "memorydb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "memorydb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "memorydb", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    switch (operation) {
      case "CreateCluster": {
        const name = body.ClusterName as string;
        const cluster: Cluster = {
          Name: name,
          Status: "available",
          NumberOfShards: (body.NumShards as number) ?? 1,
          AvailabilityMode: "MultiAZ",
          ClusterEndpoint: { Address: `clustercfg.${name}.memorydb.localhost`, Port: 6379 },
          NodeType: (body.NodeType as string) ?? "db.r6g.large",
          EngineVersion: (body.EngineVersion as string) ?? "7.0",
          ARN: `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:cluster/${name}`,
          ACLName: (body.ACLName as string) ?? "open-access",
        };
        clusters.set(name, cluster);
        jsonReply(reply, { Cluster: cluster });
        break;
      }

      case "DeleteCluster": {
        const name = body.ClusterName as string;
        const cluster = clusters.get(name);
        clusters.delete(name);
        jsonReply(reply, { Cluster: cluster ?? {} });
        break;
      }

      case "DescribeClusters": {
        const filterName = body.ClusterName as string | undefined;
        let list = Array.from(clusters.values());
        if (filterName) list = list.filter((c) => c.Name === filterName);
        jsonReply(reply, { Clusters: list });
        break;
      }

      case "CreateUser": {
        const name = body.UserName as string;
        const user: MemoryDBUser = {
          Name: name,
          Status: "active",
          AccessString: (body.AccessString as string) ?? "on ~* &* +@all",
          ARN: `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:user/${name}`,
          ACLNames: [],
        };
        users.set(name, user);
        jsonReply(reply, { User: user });
        break;
      }

      case "DeleteUser": {
        const name = body.UserName as string;
        const user = users.get(name);
        users.delete(name);
        jsonReply(reply, { User: user ?? {} });
        break;
      }

      case "DescribeUsers": {
        const filterName = body.UserName as string | undefined;
        let list = Array.from(users.values());
        if (filterName) list = list.filter((u) => u.Name === filterName);
        jsonReply(reply, { Users: list });
        break;
      }

      case "CreateACL": {
        const name = body.ACLName as string;
        const acl: ACL = {
          Name: name,
          Status: "active",
          UserNames: (body.UserNames as string[]) ?? [],
          ARN: `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:acl/${name}`,
        };
        acls.set(name, acl);
        jsonReply(reply, { ACL: acl });
        break;
      }

      case "DeleteACL": {
        const name = body.ACLName as string;
        const acl = acls.get(name);
        acls.delete(name);
        jsonReply(reply, { ACL: acl ?? {} });
        break;
      }

      case "DescribeACLs": {
        const filterName = body.ACLName as string | undefined;
        let list = Array.from(acls.values());
        if (filterName) list = list.filter((a) => a.Name === filterName);
        jsonReply(reply, { ACLs: list });
        break;
      }

      case "CreateSnapshot": {
        const name = body.SnapshotName as string;
        const clusterName = body.ClusterName as string;
        const snap: Snapshot = {
          Name: name,
          Status: "available",
          ClusterConfiguration: { Name: clusterName },
          ARN: `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:snapshot/${name}`,
        };
        snapshots.set(name, snap);
        jsonReply(reply, { Snapshot: snap });
        break;
      }

      case "DeleteSnapshot": {
        const name = body.SnapshotName as string;
        const snap = snapshots.get(name);
        snapshots.delete(name);
        jsonReply(reply, { Snapshot: snap ?? {} });
        break;
      }

      case "DescribeSnapshots": {
        const filterName = body.SnapshotName as string | undefined;
        let list = Array.from(snapshots.values());
        if (filterName) list = list.filter((s) => s.Name === filterName);
        jsonReply(reply, { Snapshots: list });
        break;
      }

      default: {
        jsonReply(
          reply,
          {
            __type: "UnknownOperationException",
            message: `lws: MemoryDB operation '${operation}' is not yet implemented`,
          },
          400,
        );
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
