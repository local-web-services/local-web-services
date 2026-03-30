/** RDS wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
const RDS_NS = "http://rds.amazonaws.com/doc/2014-10-31/";

interface DBInstance {
  DBInstanceIdentifier: string;
  DBInstanceClass: string;
  Engine: string;
  DBInstanceStatus: string;
  Endpoint: { Address: string; Port: number };
  AvailabilityZone: string;
  DBName: string;
  MasterUsername: string;
  AllocatedStorage: number;
  MultiAZ: boolean;
  DBInstanceArn: string;
  Tags: Record<string, string>;
}

interface DBSnapshot {
  DBSnapshotIdentifier: string;
  DBInstanceIdentifier: string;
  Status: string;
  Engine: string;
  AllocatedStorage: number;
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
    `<ErrorResponse xmlns="${RDS_NS}">
  <Error>
    <Code>${escapeXml(code)}</Code>
    <Message>${escapeXml(message)}</Message>
    <Type>Sender</Type>
  </Error>
  <RequestId>00000000-0000-0000-0000-000000000000</RequestId>
</ErrorResponse>`,
  );
}

function instanceXml(inst: DBInstance): string {
  const tagsXml =
    Object.keys(inst.Tags).length > 0
      ? `<TagList>${Object.entries(inst.Tags)
          .map(([k, v]) => `<Tag><Key>${escapeXml(k)}</Key><Value>${escapeXml(v)}</Value></Tag>`)
          .join("")}</TagList>`
      : "<TagList/>";
  return `<DBInstance>
      <DBInstanceIdentifier>${escapeXml(inst.DBInstanceIdentifier)}</DBInstanceIdentifier>
      <DBInstanceClass>${escapeXml(inst.DBInstanceClass)}</DBInstanceClass>
      <Engine>${escapeXml(inst.Engine)}</Engine>
      <DBInstanceStatus>${escapeXml(inst.DBInstanceStatus)}</DBInstanceStatus>
      <Endpoint>
        <Address>${escapeXml(inst.Endpoint.Address)}</Address>
        <Port>${inst.Endpoint.Port}</Port>
      </Endpoint>
      <AvailabilityZone>${escapeXml(inst.AvailabilityZone)}</AvailabilityZone>
      <DBName>${escapeXml(inst.DBName)}</DBName>
      <MasterUsername>${escapeXml(inst.MasterUsername)}</MasterUsername>
      <AllocatedStorage>${inst.AllocatedStorage}</AllocatedStorage>
      <MultiAZ>${inst.MultiAZ}</MultiAZ>
      <DBInstanceArn>${escapeXml(inst.DBInstanceArn)}</DBInstanceArn>
      ${tagsXml}
    </DBInstance>`;
}

function snapshotXml(snap: DBSnapshot): string {
  return `<DBSnapshot>
      <DBSnapshotIdentifier>${escapeXml(snap.DBSnapshotIdentifier)}</DBSnapshotIdentifier>
      <DBInstanceIdentifier>${escapeXml(snap.DBInstanceIdentifier)}</DBInstanceIdentifier>
      <Status>${escapeXml(snap.Status)}</Status>
      <Engine>${escapeXml(snap.Engine)}</Engine>
      <AllocatedStorage>${snap.AllocatedStorage}</AllocatedStorage>
      <SnapshotCreateTime>${escapeXml(snap.SnapshotCreateTime)}</SnapshotCreateTime>
    </DBSnapshot>`;
}

export function registerRds(app: FastifyInstance, state: ServerState): void {
  const instances = new Map<string, DBInstance>();
  const snapshots = new Map<string, DBSnapshot>();

  state.resetCallbacks.push(() => {
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
    const ctx = createRequestContext("rds", action);

    if (await applyIamAuth(state, "rds", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "rds", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "rds", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    switch (action) {
      case "CreateDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        if (instances.has(id)) {
          errorReply(reply, "DBInstanceAlreadyExists", `DB instance already exists: ${id}`);
          break;
        }
        const instance: DBInstance = {
          DBInstanceIdentifier: id,
          DBInstanceClass: params.get("DBInstanceClass") ?? "db.t3.micro",
          Engine: params.get("Engine") ?? "mysql",
          DBInstanceStatus: "available",
          Endpoint: { Address: `${id}.rds.localhost`, Port: 3306 },
          AvailabilityZone: "us-east-1a",
          DBName: params.get("DBName") ?? "",
          MasterUsername: params.get("MasterUsername") ?? "admin",
          AllocatedStorage: parseInt(params.get("AllocatedStorage") ?? "20", 10),
          MultiAZ: params.get("MultiAZ") === "true",
          DBInstanceArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:db:${id}`,
          Tags: {},
        };
        instances.set(id, instance);
        xmlReply(
          reply,
          xmlWrap(
            `<CreateDBInstanceResponse xmlns="${RDS_NS}">
  <CreateDBInstanceResult>
    ${instanceXml(instance)}
  </CreateDBInstanceResult>
${responseMeta()}
</CreateDBInstanceResponse>`,
          ),
          200,
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
        const finalSnapshotId = params.get("FinalDBSnapshotIdentifier");
        if (finalSnapshotId && params.get("SkipFinalSnapshot") !== "true") {
          const snap: DBSnapshot = {
            DBSnapshotIdentifier: finalSnapshotId,
            DBInstanceIdentifier: id,
            Status: "available",
            Engine: instance.Engine,
            AllocatedStorage: instance.AllocatedStorage,
            SnapshotCreateTime: new Date().toISOString(),
          };
          snapshots.set(finalSnapshotId, snap);
        }
        xmlReply(
          reply,
          xmlWrap(
            `<DeleteDBInstanceResponse xmlns="${RDS_NS}">
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
        const membersXml = list.map((i) => `    <member>${instanceXml(i)}</member>`).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            `<DescribeDBInstancesResponse xmlns="${RDS_NS}">
  <DescribeDBInstancesResult>
    <DBInstances>
${membersXml}
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
        if (params.get("AllocatedStorage"))
          instance.AllocatedStorage = parseInt(params.get("AllocatedStorage")!, 10);
        if (params.get("MultiAZ") !== null) instance.MultiAZ = params.get("MultiAZ") === "true";
        xmlReply(
          reply,
          xmlWrap(
            `<ModifyDBInstanceResponse xmlns="${RDS_NS}">
  <ModifyDBInstanceResult>
    ${instanceXml(instance)}
  </ModifyDBInstanceResult>
${responseMeta()}
</ModifyDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "CreateDBSnapshot": {
        const snapId = params.get("DBSnapshotIdentifier") ?? "";
        const instId = params.get("DBInstanceIdentifier") ?? "";
        if (snapshots.has(snapId)) {
          errorReply(reply, "DBSnapshotAlreadyExists", `DB snapshot already exists: ${snapId}`);
          break;
        }
        if (!instances.has(instId)) {
          errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${instId}`);
          break;
        }
        const instance = instances.get(instId);
        const snap: DBSnapshot = {
          DBSnapshotIdentifier: snapId,
          DBInstanceIdentifier: instId,
          Status: "available",
          Engine: instance?.Engine ?? "mysql",
          AllocatedStorage: instance?.AllocatedStorage ?? 20,
          SnapshotCreateTime: new Date().toISOString(),
        };
        snapshots.set(snapId, snap);
        xmlReply(
          reply,
          xmlWrap(
            `<CreateDBSnapshotResponse xmlns="${RDS_NS}">
  <CreateDBSnapshotResult>
    ${snapshotXml(snap)}
  </CreateDBSnapshotResult>
${responseMeta()}
</CreateDBSnapshotResponse>`,
          ),
          200,
        );
        break;
      }

      case "DeleteDBSnapshot": {
        const snapId = params.get("DBSnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        if (!snap) {
          errorReply(reply, "DBSnapshotNotFound", `DB snapshot not found: ${snapId}`);
          break;
        }
        snapshots.delete(snapId);
        xmlReply(
          reply,
          xmlWrap(
            `<DeleteDBSnapshotResponse xmlns="${RDS_NS}">
  <DeleteDBSnapshotResult>
    ${snapshotXml(snap)}
  </DeleteDBSnapshotResult>
${responseMeta()}
</DeleteDBSnapshotResponse>`,
          ),
        );
        break;
      }

      case "DescribeDBSnapshots": {
        const filterId = params.get("DBSnapshotIdentifier");
        let list = Array.from(snapshots.values());
        if (filterId) list = list.filter((s) => s.DBSnapshotIdentifier === filterId);
        const membersXml = list.map((s) => `    <member>${snapshotXml(s)}</member>`).join("\n");
        xmlReply(
          reply,
          xmlWrap(
            `<DescribeDBSnapshotsResponse xmlns="${RDS_NS}">
  <DescribeDBSnapshotsResult>
    <DBSnapshots>
${membersXml}
    </DBSnapshots>
  </DescribeDBSnapshotsResult>
${responseMeta()}
</DescribeDBSnapshotsResponse>`,
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
        xmlReply(
          reply,
          xmlWrap(
            `<RebootDBInstanceResponse xmlns="${RDS_NS}">
  <RebootDBInstanceResult>
    ${instanceXml(instance)}
  </RebootDBInstanceResult>
${responseMeta()}
</RebootDBInstanceResponse>`,
          ),
        );
        break;
      }

      case "AddTagsToResource": {
        const resourceName = params.get("ResourceName") ?? "";
        // Extract ARN parts to find the resource identifier
        const arnParts = resourceName.split(":");
        const resourceType = arnParts[5] ?? "";
        const resourceId = arnParts[6] ?? "";

        // Collect tags from numbered params: Tags.Tag.1.Key, Tags.Tag.1.Value, etc.
        const tagEntries: Array<[string, string]> = [];
        let i = 1;
        while (params.get(`Tags.Tag.${i}.Key`)) {
          const key = params.get(`Tags.Tag.${i}.Key`)!;
          const value = params.get(`Tags.Tag.${i}.Value`) ?? "";
          tagEntries.push([key, value]);
          i++;
        }

        if (resourceType === "db") {
          const instance = instances.get(resourceId);
          if (!instance) {
            errorReply(reply, "DBInstanceNotFound", `DB instance not found: ${resourceId}`);
            break;
          }
          for (const [k, v] of tagEntries) {
            instance.Tags[k] = v;
          }
        }

        xmlReply(
          reply,
          xmlWrap(
            `<AddTagsToResourceResponse xmlns="${RDS_NS}">
${responseMeta()}
</AddTagsToResourceResponse>`,
          ),
        );
        break;
      }

      case "ListTagsForResource": {
        const resourceName = params.get("ResourceName") ?? "";
        const arnParts = resourceName.split(":");
        const resourceType = arnParts[5] ?? "";
        const resourceId = arnParts[6] ?? "";

        let tags: Record<string, string> = {};
        if (resourceType === "db") {
          tags = instances.get(resourceId)?.Tags ?? {};
        }

        const tagsXml = Object.entries(tags)
          .map(
            ([k, v]) => `      <Tag><Key>${escapeXml(k)}</Key><Value>${escapeXml(v)}</Value></Tag>`,
          )
          .join("\n");

        xmlReply(
          reply,
          xmlWrap(
            `<ListTagsForResourceResponse xmlns="${RDS_NS}">
  <ListTagsForResourceResult>
    <TagList>
${tagsXml}
    </TagList>
  </ListTagsForResourceResult>
${responseMeta()}
</ListTagsForResourceResponse>`,
          ),
        );
        break;
      }

      case "RestoreDBInstanceFromDBSnapshot": {
        const newInstId = params.get("DBInstanceIdentifier") ?? "";
        const snapId = params.get("DBSnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        if (!snap) {
          errorReply(reply, "DBSnapshotNotFound", `DB snapshot not found: ${snapId}`);
          break;
        }
        const instance: DBInstance = {
          DBInstanceIdentifier: newInstId,
          DBInstanceClass: params.get("DBInstanceClass") ?? "db.t3.micro",
          Engine: snap.Engine,
          DBInstanceStatus: "restoring",
          Endpoint: { Address: `${newInstId}.rds.localhost`, Port: 3306 },
          AvailabilityZone: "us-east-1a",
          DBName: "",
          MasterUsername: "admin",
          AllocatedStorage: snap.AllocatedStorage,
          MultiAZ: false,
          DBInstanceArn: `arn:aws:rds:${REGION}:${ACCOUNT_ID}:db:${newInstId}`,
          Tags: {},
        };
        instances.set(newInstId, instance);
        xmlReply(
          reply,
          xmlWrap(
            `<RestoreDBInstanceFromDBSnapshotResponse xmlns="${RDS_NS}">
  <RestoreDBInstanceFromDBSnapshotResult>
    ${instanceXml(instance)}
  </RestoreDBInstanceFromDBSnapshotResult>
${responseMeta()}
</RestoreDBInstanceFromDBSnapshotResponse>`,
          ),
        );
        break;
      }

      default: {
        errorReply(reply, "InvalidAction", `lws: RDS action '${action}' is not yet implemented`);
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
