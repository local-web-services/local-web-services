/** ElastiCache wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface CacheCluster {
  CacheClusterId: string;
  CacheClusterStatus: string;
  Engine: string;
  EngineVersion: string;
  CacheNodeType: string;
  NumCacheNodes: number;
  CacheNodes: CacheNode[];
  CacheClusterArn: string;
}

interface CacheNode {
  CacheNodeId: string;
  CacheNodeStatus: string;
  Endpoint: { Address: string; Port: number };
}

interface ReplicationGroup {
  ReplicationGroupId: string;
  Description: string;
  Status: string;
  MemberClusters: string[];
  NodeGroups: NodeGroup[];
  AutomaticFailover: string;
}

interface NodeGroup {
  NodeGroupId: string;
  Status: string;
  PrimaryEndpoint: { Address: string; Port: number };
  ReaderEndpoint: { Address: string; Port: number };
}

interface CacheSubnetGroup {
  CacheSubnetGroupName: string;
  CacheSubnetGroupDescription: string;
  VpcId: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
}

export function registerElastiCache(app: FastifyInstance, state: ServerState): void {
  const clusters = new Map<string, CacheCluster>();
  const replicationGroups = new Map<string, ReplicationGroup>();
  const subnetGroups = new Map<string, CacheSubnetGroup>();

  state.resetCallbacks.push(() => {
    clusters.clear();
    replicationGroups.clear();
    subnetGroups.clear();
  });

  app.addContentTypeParser(
    "application/x-www-form-urlencoded",
    { parseAs: "string" },
    (_req, body, done) => done(null, body)
  );

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = new URLSearchParams(req.body as string);
    const action = params.get("Action") ?? "";
    const ctx = createRequestContext("elasticache", action);

    if (await applyIamAuth(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyChaos(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }
    if (await applyFake(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode); return;
    }

    switch (action) {
      case "CreateCacheCluster": {
        const id = params.get("CacheClusterId") ?? "";
        const numNodes = parseInt(params.get("NumCacheNodes") ?? "1", 10);
        const engine = params.get("Engine") ?? "redis";
        const port = engine === "memcached" ? 11211 : 6379;
        const cacheNodes: CacheNode[] = Array.from({ length: numNodes }, (_, i) => ({
          CacheNodeId: String(i).padStart(4, "0"),
          CacheNodeStatus: "available",
          Endpoint: { Address: `${id}.cache.localhost`, Port: port },
        }));
        const cluster: CacheCluster = {
          CacheClusterId: id,
          CacheClusterStatus: "available",
          Engine: engine,
          EngineVersion: params.get("EngineVersion") ?? "7.0.0",
          CacheNodeType: params.get("CacheNodeType") ?? "cache.t3.micro",
          NumCacheNodes: numNodes,
          CacheNodes: cacheNodes,
          CacheClusterArn: `arn:aws:elasticache:${REGION}:${ACCOUNT_ID}:cluster:${id}`,
        };
        clusters.set(id, cluster);
        jsonReply(reply, { CacheCluster: cluster });
        break;
      }

      case "DeleteCacheCluster": {
        const id = params.get("CacheClusterId") ?? "";
        const cluster = clusters.get(id);
        clusters.delete(id);
        jsonReply(reply, { CacheCluster: cluster ?? {} });
        break;
      }

      case "DescribeCacheClusters": {
        const filterId = params.get("CacheClusterId");
        let list = Array.from(clusters.values());
        if (filterId) list = list.filter((c) => c.CacheClusterId === filterId);
        jsonReply(reply, { CacheClusters: list });
        break;
      }

      case "CreateReplicationGroup": {
        const id = params.get("ReplicationGroupId") ?? "";
        const rg: ReplicationGroup = {
          ReplicationGroupId: id,
          Description: params.get("ReplicationGroupDescription") ?? "",
          Status: "available",
          MemberClusters: [],
          NodeGroups: [
            {
              NodeGroupId: "0001",
              Status: "available",
              PrimaryEndpoint: { Address: `${id}.primary.cache.localhost`, Port: 6379 },
              ReaderEndpoint: { Address: `${id}.reader.cache.localhost`, Port: 6379 },
            },
          ],
          AutomaticFailover: "enabled",
        };
        replicationGroups.set(id, rg);
        jsonReply(reply, { ReplicationGroup: rg });
        break;
      }

      case "DeleteReplicationGroup": {
        const id = params.get("ReplicationGroupId") ?? "";
        const rg = replicationGroups.get(id);
        replicationGroups.delete(id);
        jsonReply(reply, { ReplicationGroup: rg ?? {} });
        break;
      }

      case "DescribeReplicationGroups": {
        const filterId = params.get("ReplicationGroupId");
        let list = Array.from(replicationGroups.values());
        if (filterId) list = list.filter((r) => r.ReplicationGroupId === filterId);
        jsonReply(reply, { ReplicationGroups: list });
        break;
      }

      case "CreateCacheSubnetGroup": {
        const name = params.get("CacheSubnetGroupName") ?? "";
        const sg: CacheSubnetGroup = {
          CacheSubnetGroupName: name,
          CacheSubnetGroupDescription: params.get("CacheSubnetGroupDescription") ?? "",
          VpcId: "vpc-00000000",
        };
        subnetGroups.set(name, sg);
        jsonReply(reply, { CacheSubnetGroup: sg });
        break;
      }

      case "DeleteCacheSubnetGroup": {
        const name = params.get("CacheSubnetGroupName") ?? "";
        subnetGroups.delete(name);
        jsonReply(reply, {});
        break;
      }

      case "DescribeCacheSubnetGroups": {
        const filterId = params.get("CacheSubnetGroupName");
        let list = Array.from(subnetGroups.values());
        if (filterId) list = list.filter((s) => s.CacheSubnetGroupName === filterId);
        jsonReply(reply, { CacheSubnetGroups: list });
        break;
      }

      default: {
        jsonReply(reply, {
          __type: "UnknownOperationException",
          message: `lws: ElastiCache action '${action}' is not yet implemented`,
        }, 400);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
