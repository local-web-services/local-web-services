/** Neptune wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
const NEPTUNE_NS = "http://rds.amazonaws.com/doc/2014-10-31/";

interface DBCluster {
  DBClusterIdentifier: string;
  Status: string;
  Engine: string;
  Endpoint: string;
  ReaderEndpoint: string;
  Port: number;
  DBClusterArn: string;
  DBClusterMembers: DBClusterMember[];
  MultiAZ: boolean;
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

// ── XML helpers ───────────────────────────────────────────────────────────────

function escapeXml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

function xmlWrap(content: string): string {
  return `<?xml version="1.0" encoding="UTF-8"?>\n${content}`;
}

function responseMeta(): string {
  return `  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>`;
}

function errorXml(code: string, message: string): string {
  return xmlWrap(
    `<ErrorResponse xmlns="${NEPTUNE_NS}">
  <Error>
    <Code>${escapeXml(code)}</Code>
    <Message>${escapeXml(message)}</Message>
    <Type>Sender</Type>
  </Error>
  <RequestId>00000000-0000-0000-0000-000000000000</RequestId>
</ErrorResponse>`,
  );
}

function clusterMemberXml(m: DBClusterMember): string {
  return `<DBClusterMember>
          <DBInstanceIdentifier>${escapeXml(m.DBInstanceIdentifier)}</DBInstanceIdentifier>
          <IsClusterWriter>${m.IsClusterWriter}</IsClusterWriter>
          <DBClusterParameterGroupStatus>${escapeXml(m.DBClusterParameterGroupStatus)}</DBClusterParameterGroupStatus>
        </DBClusterMember>`;
}

function clusterXml(cluster: DBCluster): string {
  const membersXml =
    cluster.DBClusterMembers.length > 0
      ? `<DBClusterMembers>${cluster.DBClusterMembers.map(clusterMemberXml).join("")}</DBClusterMembers>`
      : "<DBClusterMembers/>";
  return `<DBCluster>
      <DBClusterIdentifier>${escapeXml(cluster.DBClusterIdentifier)}</DBClusterIdentifier>
      <Status>${escapeXml(cluster.Status)}</Status>
      <Engine>${escapeXml(cluster.Engine)}</Engine>
      <Endpoint>${escapeXml(cluster.Endpoint)}</Endpoint>
      <ReaderEndpoint>${escapeXml(cluster.ReaderEndpoint)}</ReaderEndpoint>
      <Port>${cluster.Port}</Port>
      <DBClusterArn>${escapeXml(cluster.DBClusterArn)}</DBClusterArn>
      <MultiAZ>${cluster.MultiAZ}</MultiAZ>
      ${membersXml}
    </DBCluster>`;
}

function instanceXml(inst: DBInstance): string {
  return `<DBInstance>
      <DBInstanceIdentifier>${escapeXml(inst.DBInstanceIdentifier)}</DBInstanceIdentifier>
      <DBClusterIdentifier>${escapeXml(inst.DBClusterIdentifier)}</DBClusterIdentifier>
      <DBInstanceClass>${escapeXml(inst.DBInstanceClass)}</DBInstanceClass>
      <Engine>${escapeXml(inst.Engine)}</Engine>
      <DBInstanceStatus>${escapeXml(inst.DBInstanceStatus)}</DBInstanceStatus>
      <Endpoint>
        <Address>${escapeXml(inst.Endpoint.Address)}</Address>
        <Port>${inst.Endpoint.Port}</Port>
      </Endpoint>
      <DBInstanceArn>${escapeXml(inst.DBInstanceArn)}</DBInstanceArn>
    </DBInstance>`;
}

function snapshotXml(snap: DBClusterSnapshot): string {
  return `<DBClusterSnapshot>
      <DBClusterSnapshotIdentifier>${escapeXml(snap.DBClusterSnapshotIdentifier)}</DBClusterSnapshotIdentifier>
      <DBClusterIdentifier>${escapeXml(snap.DBClusterIdentifier)}</DBClusterIdentifier>
      <Status>${escapeXml(snap.Status)}</Status>
      <Engine>${escapeXml(snap.Engine)}</Engine>
      <SnapshotCreateTime>${escapeXml(snap.SnapshotCreateTime)}</SnapshotCreateTime>
    </DBClusterSnapshot>`;
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
    (_req, body, done) => done(null, body),
  );

  const xmlReply = (reply: FastifyReply, content: string, status = 200) => {
    reply.status(status).header("Content-Type", "text/xml").send(content);
  };

  const errorReply = (reply: FastifyReply, code: string, message: string, status = 400) => {
    xmlReply(reply, errorXml(code, message), status);
  };

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = new URLSearchParams(req.body as string);
    const action = params.get("Action") ?? "";
    const ctx = createRequestContext("neptune", action);

    if (await applyIamAuth(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "neptune", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    switch (action) {
      case "CreateDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        if (clusters.has(id)) {
          errorReply(reply, "DBClusterAlreadyExistsFault", `DB cluster already exists: ${id}`);
          break;
        }
        const cluster: DBCluster = {
          DBClusterIdentifier: id,
          Status: "available",
          Engine: params.get("Engine") ?? "neptune",
          Endpoint: `${id}.cluster.neptune.localhost`,
          ReaderEndpoint: `${id}.cluster-ro.neptune.localhost`,
          Port: 8182,
          DBClusterArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:cluster:${id}`,
          DBClusterMembers: [],
          MultiAZ: false,
        };
        clusters.set(id, cluster);
        // Return "creating" in the response to model the transitional state the client sees
        const responseCluster = { ...cluster, Status: "creating" };
        xmlReply(
          reply,
          xmlWrap(
            `<CreateDBClusterResponse xmlns="${NEPTUNE_NS}">
  <CreateDBClusterResult>
    ${clusterXml(responseCluster)}
  </CreateDBClusterResult>
${responseMeta()}
</CreateDBClusterResponse>`,
          ),
        );
        break;
      }

      case "DeleteDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${id}`);
          break;
        }
        cluster.Status = "deleting";
        clusters.delete(id);
        xmlReply(
          reply,
          xmlWrap(
            `<DeleteDBClusterResponse xmlns="${NEPTUNE_NS}">
  <DeleteDBClusterResult>
    ${clusterXml(cluster)}
  </DeleteDBClusterResult>
${responseMeta()}
</DeleteDBClusterResponse>`,
          ),
        );
        break;
      }

      case "DescribeDBClusters": {
        const filterId = params.get("DBClusterIdentifier");
        let list = Array.from(clusters.values());
        if (filterId) {
          list = list.filter((c) => c.DBClusterIdentifier === filterId);
          if (list.length === 0) {
            errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${filterId}`);
            break;
          }
        }
        const itemsXml = list.map((c) => `    ${clusterXml(c)}`).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            `<DescribeDBClustersResponse xmlns="${NEPTUNE_NS}">
  <DescribeDBClustersResult>
    <DBClusters>
${itemsXml}
    </DBClusters>
  </DescribeDBClustersResult>
${responseMeta()}
</DescribeDBClustersResponse>`,
          ),
        );
        break;
      }

      case "ModifyDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${id}`);
          break;
        }
        if (params.get("MultiAZ") !== null) cluster.MultiAZ = params.get("MultiAZ") === "true";
        // Return "modifying" in the response to model the transitional state
        const responseCluster = { ...cluster, Status: "modifying" };
        xmlReply(
          reply,
          xmlWrap(
            `<ModifyDBClusterResponse xmlns="${NEPTUNE_NS}">
  <ModifyDBClusterResult>
    ${clusterXml(responseCluster)}
  </ModifyDBClusterResult>
${responseMeta()}
</ModifyDBClusterResponse>`,
          ),
        );
        break;
      }

      case "StopDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${id}`);
          break;
        }
        cluster.Status = "stopping";
        xmlReply(
          reply,
          xmlWrap(
            `<StopDBClusterResponse xmlns="${NEPTUNE_NS}">
  <StopDBClusterResult>
    ${clusterXml(cluster)}
  </StopDBClusterResult>
${responseMeta()}
</StopDBClusterResponse>`,
          ),
        );
        break;
      }

      case "StartDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${id}`);
          break;
        }
        cluster.Status = "starting";
        xmlReply(
          reply,
          xmlWrap(
            `<StartDBClusterResponse xmlns="${NEPTUNE_NS}">
  <StartDBClusterResult>
    ${clusterXml(cluster)}
  </StartDBClusterResult>
${responseMeta()}
</StartDBClusterResponse>`,
          ),
        );
        break;
      }

      case "FailoverDBCluster": {
        const id = params.get("DBClusterIdentifier") ?? "";
        const cluster = clusters.get(id);
        if (!cluster) {
          errorReply(reply, "DBClusterNotFoundFault", `DB cluster not found: ${id}`);
          break;
        }
        if (!cluster.MultiAZ) {
          errorReply(
            reply,
            "InvalidDBClusterStateFault",
            `Cluster ${id} does not have multi-AZ enabled`,
          );
          break;
        }
        cluster.Status = "modifying";
        xmlReply(
          reply,
          xmlWrap(
            `<FailoverDBClusterResponse xmlns="${NEPTUNE_NS}">
  <FailoverDBClusterResult>
    ${clusterXml(cluster)}
  </FailoverDBClusterResult>
${responseMeta()}
</FailoverDBClusterResponse>`,
          ),
        );
        break;
      }

      case "CreateDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const clusterId = params.get("DBClusterIdentifier") ?? "";
        if (instances.has(id)) {
          errorReply(reply, "DBInstanceAlreadyExists", `DB instance already exists: ${id}`);
          break;
        }
        const instance: DBInstance = {
          DBInstanceIdentifier: id,
          DBClusterIdentifier: clusterId,
          DBInstanceClass: params.get("DBInstanceClass") ?? "db.r5.large",
          Engine: params.get("Engine") ?? "neptune",
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
        // Return "creating" in the response to model the transitional state
        const responseInstance = { ...instance, DBInstanceStatus: "creating" };
        xmlReply(
          reply,
          xmlWrap(
            `<CreateDBInstanceResponse xmlns="${NEPTUNE_NS}">
  <CreateDBInstanceResult>
    ${instanceXml(responseInstance)}
  </CreateDBInstanceResult>
${responseMeta()}
</CreateDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "DeleteDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        if (!instance) {
          errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${id}`);
          break;
        }
        instance.DBInstanceStatus = "deleting";
        instances.delete(id);
        xmlReply(
          reply,
          xmlWrap(
            `<DeleteDBInstanceResponse xmlns="${NEPTUNE_NS}">
  <DeleteDBInstanceResult>
    ${instanceXml(instance)}
  </DeleteDBInstanceResult>
${responseMeta()}
</DeleteDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "DescribeDBInstances": {
        const filterId = params.get("DBInstanceIdentifier");
        let list = Array.from(instances.values());
        if (filterId) {
          list = list.filter((i) => i.DBInstanceIdentifier === filterId);
          if (list.length === 0) {
            errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${filterId}`);
            break;
          }
        }
        const itemsXml = list.map((i) => `    ${instanceXml(i)}`).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            `<DescribeDBInstancesResponse xmlns="${NEPTUNE_NS}">
  <DescribeDBInstancesResult>
    <DBInstances>
${itemsXml}
    </DBInstances>
  </DescribeDBInstancesResult>
${responseMeta()}
</DescribeDBInstancesResponse>`,
          ),
        );
        break;
      }

      case "ModifyDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        if (!instance) {
          errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${id}`);
          break;
        }
        if (params.get("DBInstanceClass"))
          instance.DBInstanceClass = params.get("DBInstanceClass")!;
        // Return "modifying" in the response to model the transitional state
        const responseInstance = { ...instance, DBInstanceStatus: "modifying" };
        xmlReply(
          reply,
          xmlWrap(
            `<ModifyDBInstanceResponse xmlns="${NEPTUNE_NS}">
  <ModifyDBInstanceResult>
    ${instanceXml(responseInstance)}
  </ModifyDBInstanceResult>
${responseMeta()}
</ModifyDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "RebootDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        if (!instance) {
          errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${id}`);
          break;
        }
        // Return "rebooting" in the response to model the transitional state
        const responseInstance = { ...instance, DBInstanceStatus: "rebooting" };
        xmlReply(
          reply,
          xmlWrap(
            `<RebootDBInstanceResponse xmlns="${NEPTUNE_NS}">
  <RebootDBInstanceResult>
    ${instanceXml(responseInstance)}
  </RebootDBInstanceResult>
${responseMeta()}
</RebootDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "CreateDBClusterSnapshot": {
        const snapId = params.get("DBClusterSnapshotIdentifier") ?? "";
        const clusterId = params.get("DBClusterIdentifier") ?? "";
        if (snapshots.has(snapId)) {
          errorReply(
            reply,
            "DBClusterSnapshotAlreadyExistsFault",
            `DB cluster snapshot already exists: ${snapId}`,
          );
          break;
        }
        const cluster = clusters.get(clusterId);
        const snap: DBClusterSnapshot = {
          DBClusterSnapshotIdentifier: snapId,
          DBClusterIdentifier: clusterId,
          Status: "available",
          Engine: cluster?.Engine ?? "neptune",
          SnapshotCreateTime: new Date().toISOString(),
        };
        snapshots.set(snapId, snap);
        // Return "creating" in the response to model the transitional state
        const responseSnap = { ...snap, Status: "creating" };
        xmlReply(
          reply,
          xmlWrap(
            `<CreateDBClusterSnapshotResponse xmlns="${NEPTUNE_NS}">
  <CreateDBClusterSnapshotResult>
    ${snapshotXml(responseSnap)}
  </CreateDBClusterSnapshotResult>
${responseMeta()}
</CreateDBClusterSnapshotResponse>`,
          ),
        );
        break;
      }

      case "DeleteDBClusterSnapshot": {
        const snapId = params.get("DBClusterSnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        if (!snap) {
          errorReply(
            reply,
            "DBClusterSnapshotNotFoundFault",
            `DB cluster snapshot not found: ${snapId}`,
          );
          break;
        }
        snap.Status = "deleting";
        snapshots.delete(snapId);
        xmlReply(
          reply,
          xmlWrap(
            `<DeleteDBClusterSnapshotResponse xmlns="${NEPTUNE_NS}">
  <DeleteDBClusterSnapshotResult>
    ${snapshotXml(snap)}
  </DeleteDBClusterSnapshotResult>
${responseMeta()}
</DeleteDBClusterSnapshotResponse>`,
          ),
        );
        break;
      }

      case "DescribeDBClusterSnapshots": {
        const filterId = params.get("DBClusterSnapshotIdentifier");
        let list = Array.from(snapshots.values());
        if (filterId) {
          list = list.filter((s) => s.DBClusterSnapshotIdentifier === filterId);
          if (list.length === 0) {
            errorReply(
              reply,
              "DBClusterSnapshotNotFoundFault",
              `DB cluster snapshot not found: ${filterId}`,
            );
            break;
          }
        }
        const itemsXml = list.map((s) => `    ${snapshotXml(s)}`).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            `<DescribeDBClusterSnapshotsResponse xmlns="${NEPTUNE_NS}">
  <DescribeDBClusterSnapshotsResult>
    <DBClusterSnapshots>
${itemsXml}
    </DBClusterSnapshots>
  </DescribeDBClusterSnapshotsResult>
${responseMeta()}
</DescribeDBClusterSnapshotsResponse>`,
          ),
        );
        break;
      }

      case "RestoreDBClusterFromSnapshot": {
        const newClusterId = params.get("DBClusterIdentifier") ?? "";
        const snapId = params.get("SnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        if (!snap) {
          errorReply(
            reply,
            "DBClusterSnapshotNotFoundFault",
            `DB cluster snapshot not found: ${snapId}`,
          );
          break;
        }
        const cluster: DBCluster = {
          DBClusterIdentifier: newClusterId,
          Status: "restoring",
          Engine: params.get("Engine") ?? snap.Engine,
          Endpoint: `${newClusterId}.cluster.neptune.localhost`,
          ReaderEndpoint: `${newClusterId}.cluster-ro.neptune.localhost`,
          Port: 8182,
          DBClusterArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:cluster:${newClusterId}`,
          DBClusterMembers: [],
          MultiAZ: false,
        };
        clusters.set(newClusterId, cluster);
        xmlReply(
          reply,
          xmlWrap(
            `<RestoreDBClusterFromSnapshotResponse xmlns="${NEPTUNE_NS}">
  <RestoreDBClusterFromSnapshotResult>
    ${clusterXml(cluster)}
  </RestoreDBClusterFromSnapshotResult>
${responseMeta()}
</RestoreDBClusterFromSnapshotResponse>`,
          ),
        );
        break;
      }

      default: {
        errorReply(
          reply,
          "InvalidAction",
          `lws: Neptune action '${action}' is not yet implemented`,
        );
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
