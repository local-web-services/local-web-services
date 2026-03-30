/** ElastiCache wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
const NS = "http://elasticache.amazonaws.com/doc/2015-02-02/";
const REQUEST_ID = "00000000-0000-0000-0000-000000000000";

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

interface Snapshot {
  SnapshotName: string;
  CacheClusterId: string;
  SnapshotStatus: string;
  Engine: string;
}

interface CacheParameterGroup {
  CacheParameterGroupName: string;
  CacheParameterGroupFamily: string;
  Description: string;
}

// ── XML helpers ───────────────────────────────────────────────────────────────

function escapeXml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

function xmlWrap(action: string, inner: string): string {
  return `<?xml version="1.0" encoding="UTF-8"?>
<${action}Response xmlns="${NS}">
  <${action}Result>
${inner}
  </${action}Result>
  <ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata>
</${action}Response>`;
}

function xmlWrapNoResult(action: string): string {
  return `<?xml version="1.0" encoding="UTF-8"?>
<${action}Response xmlns="${NS}">
  <ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata>
</${action}Response>`;
}

function xmlError(code: string, message: string): string {
  return `<?xml version="1.0" encoding="UTF-8"?>
<ErrorResponse xmlns="${NS}">
  <Error>
    <Code>${escapeXml(code)}</Code>
    <Message>${escapeXml(message)}</Message>
  </Error>
  <RequestId>${REQUEST_ID}</RequestId>
</ErrorResponse>`;
}

function xmlReply(reply: FastifyReply, xml: string, status = 200): void {
  reply.status(status).header("Content-Type", "text/xml").send(xml);
}

// ── Cluster XML serialisers ───────────────────────────────────────────────────

function clusterXml(c: CacheCluster): string {
  const nodesXml = c.CacheNodes.map(
    (n) =>
      `      <CacheNode>
        <CacheNodeId>${escapeXml(n.CacheNodeId)}</CacheNodeId>
        <CacheNodeStatus>${escapeXml(n.CacheNodeStatus)}</CacheNodeStatus>
        <Endpoint>
          <Address>${escapeXml(n.Endpoint.Address)}</Address>
          <Port>${n.Endpoint.Port}</Port>
        </Endpoint>
      </CacheNode>`,
  ).join("\n");

  return `    <CacheCluster>
      <CacheClusterId>${escapeXml(c.CacheClusterId)}</CacheClusterId>
      <CacheClusterStatus>${escapeXml(c.CacheClusterStatus)}</CacheClusterStatus>
      <Engine>${escapeXml(c.Engine)}</Engine>
      <EngineVersion>${escapeXml(c.EngineVersion)}</EngineVersion>
      <CacheNodeType>${escapeXml(c.CacheNodeType)}</CacheNodeType>
      <NumCacheNodes>${c.NumCacheNodes}</NumCacheNodes>
      <CacheClusterArn>${escapeXml(c.CacheClusterArn)}</CacheClusterArn>
      <CacheNodes>
${nodesXml}
      </CacheNodes>
    </CacheCluster>`;
}

function replicationGroupXml(rg: ReplicationGroup): string {
  const memberXml = rg.MemberClusters.map(
    (m) => `      <ClusterId>${escapeXml(m)}</ClusterId>`,
  ).join("\n");

  const ngXml = rg.NodeGroups.map(
    (ng) =>
      `      <NodeGroup>
        <NodeGroupId>${escapeXml(ng.NodeGroupId)}</NodeGroupId>
        <Status>${escapeXml(ng.Status)}</Status>
        <PrimaryEndpoint>
          <Address>${escapeXml(ng.PrimaryEndpoint.Address)}</Address>
          <Port>${ng.PrimaryEndpoint.Port}</Port>
        </PrimaryEndpoint>
        <ReaderEndpoint>
          <Address>${escapeXml(ng.ReaderEndpoint.Address)}</Address>
          <Port>${ng.ReaderEndpoint.Port}</Port>
        </ReaderEndpoint>
      </NodeGroup>`,
  ).join("\n");

  return `    <ReplicationGroup>
      <ReplicationGroupId>${escapeXml(rg.ReplicationGroupId)}</ReplicationGroupId>
      <Description>${escapeXml(rg.Description)}</Description>
      <Status>${escapeXml(rg.Status)}</Status>
      <AutomaticFailover>${escapeXml(rg.AutomaticFailover)}</AutomaticFailover>
      <MemberClusters>
${memberXml}
      </MemberClusters>
      <NodeGroups>
${ngXml}
      </NodeGroups>
    </ReplicationGroup>`;
}

function subnetGroupXml(sg: CacheSubnetGroup): string {
  return `    <CacheSubnetGroup>
      <CacheSubnetGroupName>${escapeXml(sg.CacheSubnetGroupName)}</CacheSubnetGroupName>
      <CacheSubnetGroupDescription>${escapeXml(sg.CacheSubnetGroupDescription)}</CacheSubnetGroupDescription>
      <VpcId>${escapeXml(sg.VpcId)}</VpcId>
    </CacheSubnetGroup>`;
}

function snapshotXml(s: Snapshot): string {
  return `    <Snapshot>
      <SnapshotName>${escapeXml(s.SnapshotName)}</SnapshotName>
      <CacheClusterId>${escapeXml(s.CacheClusterId)}</CacheClusterId>
      <SnapshotStatus>${escapeXml(s.SnapshotStatus)}</SnapshotStatus>
      <Engine>${escapeXml(s.Engine)}</Engine>
    </Snapshot>`;
}

function paramGroupXml(pg: CacheParameterGroup): string {
  return `    <CacheParameterGroup>
      <CacheParameterGroupName>${escapeXml(pg.CacheParameterGroupName)}</CacheParameterGroupName>
      <CacheParameterGroupFamily>${escapeXml(pg.CacheParameterGroupFamily)}</CacheParameterGroupFamily>
      <Description>${escapeXml(pg.Description)}</Description>
    </CacheParameterGroup>`;
}

// ── ARN existence check ───────────────────────────────────────────────────────

function arnResourceExists(
  arn: string,
  clusters: Map<string, CacheCluster>,
  replicationGroups: Map<string, ReplicationGroup>,
): boolean {
  // arn:aws:elasticache:region:account:cluster:id
  // arn:aws:elasticache:region:account:replicationgroup:id
  const parts = arn.split(":");
  const resourceType = parts[5];
  const resourceId = parts[6];
  if (resourceType === "cluster") return clusters.has(resourceId);
  if (resourceType === "replicationgroup") return replicationGroups.has(resourceId);
  return false;
}

// ── Plugin registration ───────────────────────────────────────────────────────

export function registerElastiCache(app: FastifyInstance, state: ServerState): void {
  const clusters = new Map<string, CacheCluster>();
  const replicationGroups = new Map<string, ReplicationGroup>();
  const subnetGroups = new Map<string, CacheSubnetGroup>();
  const snapshots = new Map<string, Snapshot>();
  const parameterGroups = new Map<string, CacheParameterGroup>();
  const resourceTags = new Map<string, Record<string, string>>();

  state.resetCallbacks.push(() => {
    clusters.clear();
    replicationGroups.clear();
    subnetGroups.clear();
    snapshots.clear();
    parameterGroups.clear();
    resourceTags.clear();
  });

  app.addContentTypeParser(
    "application/x-www-form-urlencoded",
    { parseAs: "string" },
    (_req, body, done) => done(null, body),
  );

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = new URLSearchParams(req.body as string);
    const action = params.get("Action") ?? "";
    const ctx = createRequestContext("elasticache", action);

    if (await applyIamAuth(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "elasticache", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    switch (action) {
      case "CreateCacheCluster": {
        const id = params.get("CacheClusterId") ?? "";
        if (clusters.has(id)) {
          xmlReply(
            reply,
            xmlError("CacheClusterAlreadyExists", `Cache cluster ${id} already exists`),
            400,
          );
          break;
        }
        const snapshotNameParam = params.get("SnapshotName");
        if (snapshotNameParam && !snapshots.has(snapshotNameParam)) {
          xmlReply(
            reply,
            xmlError("SnapshotNotFoundFault", `Snapshot ${snapshotNameParam} not found`),
            400,
          );
          break;
        }
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
        xmlReply(reply, xmlWrap("CreateCacheCluster", clusterXml(cluster)));
        break;
      }

      case "DeleteCacheCluster": {
        const id = params.get("CacheClusterId") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          xmlReply(reply, xmlError("CacheClusterNotFound", `Cache cluster ${id} not found`), 400);
          break;
        }
        clusters.delete(id);
        xmlReply(reply, xmlWrap("DeleteCacheCluster", clusterXml(cluster)));
        break;
      }

      case "DescribeCacheClusters": {
        const filterId = params.get("CacheClusterId");
        let list = Array.from(clusters.values());
        if (filterId) list = list.filter((c) => c.CacheClusterId === filterId);
        const inner = list.map(clusterXml).join("\n");
        xmlReply(
          reply,
          xmlWrap("DescribeCacheClusters", `    <CacheClusters>\n${inner}\n    </CacheClusters>`),
        );
        break;
      }

      case "ModifyCacheCluster": {
        const id = params.get("CacheClusterId") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          xmlReply(reply, xmlError("CacheClusterNotFound", `Cache cluster ${id} not found`), 400);
          break;
        }
        xmlReply(reply, xmlWrap("ModifyCacheCluster", clusterXml(cluster)));
        break;
      }

      case "CreateReplicationGroup": {
        const id = params.get("ReplicationGroupId") ?? "";
        if (replicationGroups.has(id)) {
          xmlReply(
            reply,
            xmlError("ReplicationGroupAlreadyExists", `Replication group ${id} already exists`),
            400,
          );
          break;
        }
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
        xmlReply(reply, xmlWrap("CreateReplicationGroup", replicationGroupXml(rg)));
        break;
      }

      case "DeleteReplicationGroup": {
        const id = params.get("ReplicationGroupId") ?? "";
        const rg = replicationGroups.get(id);
        if (!rg) {
          xmlReply(
            reply,
            xmlError("ReplicationGroupNotFoundFault", `Replication group ${id} not found`),
            400,
          );
          break;
        }
        replicationGroups.delete(id);
        xmlReply(reply, xmlWrap("DeleteReplicationGroup", replicationGroupXml(rg)));
        break;
      }

      case "DescribeReplicationGroups": {
        const filterId = params.get("ReplicationGroupId");
        let list = Array.from(replicationGroups.values());
        if (filterId) list = list.filter((r) => r.ReplicationGroupId === filterId);
        const inner = list.map(replicationGroupXml).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            "DescribeReplicationGroups",
            `    <ReplicationGroups>\n${inner}\n    </ReplicationGroups>`,
          ),
        );
        break;
      }

      case "ModifyReplicationGroup": {
        const id = params.get("ReplicationGroupId") ?? "";
        const rg = replicationGroups.get(id);
        if (!rg) {
          xmlReply(
            reply,
            xmlError("ReplicationGroupNotFoundFault", `Replication group ${id} not found`),
            400,
          );
          break;
        }
        xmlReply(reply, xmlWrap("ModifyReplicationGroup", replicationGroupXml(rg)));
        break;
      }

      case "CreateCacheSubnetGroup": {
        const name = params.get("CacheSubnetGroupName") ?? "";
        if (subnetGroups.has(name)) {
          xmlReply(
            reply,
            xmlError("CacheSubnetGroupAlreadyExists", `Cache subnet group ${name} already exists`),
            400,
          );
          break;
        }
        const sg: CacheSubnetGroup = {
          CacheSubnetGroupName: name,
          CacheSubnetGroupDescription: params.get("CacheSubnetGroupDescription") ?? "",
          VpcId: "vpc-00000000",
        };
        subnetGroups.set(name, sg);
        xmlReply(reply, xmlWrap("CreateCacheSubnetGroup", subnetGroupXml(sg)));
        break;
      }

      case "DeleteCacheSubnetGroup": {
        const name = params.get("CacheSubnetGroupName") ?? "";
        if (!subnetGroups.has(name)) {
          xmlReply(
            reply,
            xmlError("CacheSubnetGroupNotFoundFault", `Cache subnet group ${name} not found`),
            400,
          );
          break;
        }
        subnetGroups.delete(name);
        xmlReply(reply, xmlWrapNoResult("DeleteCacheSubnetGroup"));
        break;
      }

      case "DescribeCacheSubnetGroups": {
        const filterId = params.get("CacheSubnetGroupName");
        let list = Array.from(subnetGroups.values());
        if (filterId) list = list.filter((s) => s.CacheSubnetGroupName === filterId);
        const inner = list.map(subnetGroupXml).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            "DescribeCacheSubnetGroups",
            `    <CacheSubnetGroups>\n${inner}\n    </CacheSubnetGroups>`,
          ),
        );
        break;
      }

      case "CreateSnapshot": {
        const snapshotName = params.get("SnapshotName") ?? "";
        const clusterId = params.get("CacheClusterId") ?? "";
        const cluster = clusters.get(clusterId);
        if (!cluster) {
          xmlReply(
            reply,
            xmlError("CacheClusterNotFound", `Cache cluster ${clusterId} not found`),
            400,
          );
          break;
        }
        if (cluster.Engine !== "redis") {
          xmlReply(
            reply,
            xmlError("InvalidParameterValue", "Snapshots are only supported for Redis clusters"),
            400,
          );
          break;
        }
        const snapshot: Snapshot = {
          SnapshotName: snapshotName,
          CacheClusterId: clusterId,
          SnapshotStatus: "creating",
          Engine: cluster.Engine,
        };
        snapshots.set(snapshotName, snapshot);
        xmlReply(reply, xmlWrap("CreateSnapshot", snapshotXml(snapshot)));
        break;
      }

      case "DeleteSnapshot": {
        const snapshotName = params.get("SnapshotName") ?? "";
        const snapshot = snapshots.get(snapshotName);
        if (!snapshot) {
          xmlReply(
            reply,
            xmlError("SnapshotNotFoundFault", `Snapshot ${snapshotName} not found`),
            400,
          );
          break;
        }
        snapshots.delete(snapshotName);
        xmlReply(reply, xmlWrap("DeleteSnapshot", snapshotXml(snapshot)));
        break;
      }

      case "DescribeSnapshots": {
        const filterName = params.get("SnapshotName");
        let list = Array.from(snapshots.values());
        if (filterName) list = list.filter((s) => s.SnapshotName === filterName);
        const inner = list.map(snapshotXml).join("\n");
        xmlReply(
          reply,
          xmlWrap("DescribeSnapshots", `    <Snapshots>\n${inner}\n    </Snapshots>`),
        );
        break;
      }

      case "CreateCacheParameterGroup": {
        const groupName = params.get("CacheParameterGroupName") ?? "";
        if (parameterGroups.has(groupName)) {
          xmlReply(
            reply,
            xmlError(
              "CacheParameterGroupAlreadyExists",
              `Cache parameter group ${groupName} already exists`,
            ),
            400,
          );
          break;
        }
        const pg: CacheParameterGroup = {
          CacheParameterGroupName: groupName,
          CacheParameterGroupFamily: params.get("CacheParameterGroupFamily") ?? "redis7",
          Description: params.get("Description") ?? "",
        };
        parameterGroups.set(groupName, pg);
        xmlReply(reply, xmlWrap("CreateCacheParameterGroup", paramGroupXml(pg)));
        break;
      }

      case "DeleteCacheParameterGroup": {
        const groupName = params.get("CacheParameterGroupName") ?? "";
        if (!parameterGroups.has(groupName)) {
          xmlReply(
            reply,
            xmlError("CacheParameterGroupNotFound", `Cache parameter group ${groupName} not found`),
            400,
          );
          break;
        }
        parameterGroups.delete(groupName);
        xmlReply(reply, xmlWrapNoResult("DeleteCacheParameterGroup"));
        break;
      }

      case "DescribeCacheParameterGroups": {
        const filterName = params.get("CacheParameterGroupName");
        let list = Array.from(parameterGroups.values());
        if (filterName) list = list.filter((p) => p.CacheParameterGroupName === filterName);
        const inner = list.map(paramGroupXml).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            "DescribeCacheParameterGroups",
            `    <CacheParameterGroups>\n${inner}\n    </CacheParameterGroups>`,
          ),
        );
        break;
      }

      case "AddTagsToResource": {
        const arn = params.get("ResourceName") ?? "";
        const resourceExists = arnResourceExists(arn, clusters, replicationGroups);
        if (!resourceExists) {
          xmlReply(reply, xmlError("InvalidARN", `Resource ${arn} not found`), 400);
          break;
        }
        const newTags = resourceTags.get(arn) ?? {};
        let tagIdx = 1;
        while (params.get(`Tags.member.${tagIdx}.Key`)) {
          const key = params.get(`Tags.member.${tagIdx}.Key`) ?? "";
          const value = params.get(`Tags.member.${tagIdx}.Value`) ?? "";
          newTags[key] = value;
          tagIdx++;
        }
        resourceTags.set(arn, newTags);
        const addTagsXml = Object.entries(newTags)
          .map(
            ([k, v]) =>
              `    <member>
      <Key>${escapeXml(k)}</Key>
      <Value>${escapeXml(v)}</Value>
    </member>`,
          )
          .join("\n");
        xmlReply(
          reply,
          xmlWrap("AddTagsToResource", `    <TagList>\n${addTagsXml}\n    </TagList>`),
        );
        break;
      }

      case "RemoveTagsFromResource": {
        const arn = params.get("ResourceName") ?? "";
        const resourceExists = arnResourceExists(arn, clusters, replicationGroups);
        if (!resourceExists) {
          xmlReply(reply, xmlError("InvalidARN", `Resource ${arn} not found`), 400);
          break;
        }
        const existingTags = resourceTags.get(arn) ?? {};
        let removeIdx = 1;
        while (params.get(`TagKeys.member.${removeIdx}`)) {
          const key = params.get(`TagKeys.member.${removeIdx}`) ?? "";
          delete existingTags[key];
          removeIdx++;
        }
        resourceTags.set(arn, existingTags);
        const removeTagsXml = Object.entries(existingTags)
          .map(
            ([k, v]) =>
              `    <member>
      <Key>${escapeXml(k)}</Key>
      <Value>${escapeXml(v)}</Value>
    </member>`,
          )
          .join("\n");
        xmlReply(
          reply,
          xmlWrap("RemoveTagsFromResource", `    <TagList>\n${removeTagsXml}\n    </TagList>`),
        );
        break;
      }

      default: {
        xmlReply(
          reply,
          xmlError("InvalidAction", `lws: ElastiCache action '${action}' is not yet implemented`),
          400,
        );
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
