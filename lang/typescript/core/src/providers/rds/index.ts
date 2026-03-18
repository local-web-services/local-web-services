/** RDS wire-protocol Fastify plugin (AWS Query protocol). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

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
}

interface DBSnapshot {
  DBSnapshotIdentifier: string;
  DBInstanceIdentifier: string;
  Status: string;
  Engine: string;
  AllocatedStorage: number;
  SnapshotCreateTime: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
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
        };
        instances.set(id, instance);
        jsonReply(reply, { DBInstance: instance }, 201);
        break;
      }

      case "DeleteDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        if (instance) {
          instance.DBInstanceStatus = "deleting";
          instances.delete(id);
        }
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

      case "ModifyDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        if (instance) {
          if (params.get("DBInstanceClass"))
            instance.DBInstanceClass = params.get("DBInstanceClass")!;
          if (params.get("AllocatedStorage"))
            instance.AllocatedStorage = parseInt(params.get("AllocatedStorage")!, 10);
        }
        jsonReply(reply, { DBInstance: instance ?? {} });
        break;
      }

      case "CreateDBSnapshot": {
        const snapId = params.get("DBSnapshotIdentifier") ?? "";
        const instId = params.get("DBInstanceIdentifier") ?? "";
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
        jsonReply(reply, { DBSnapshot: snap }, 201);
        break;
      }

      case "DeleteDBSnapshot": {
        const snapId = params.get("DBSnapshotIdentifier") ?? "";
        const snap = snapshots.get(snapId);
        snapshots.delete(snapId);
        jsonReply(reply, { DBSnapshot: snap ?? {} });
        break;
      }

      case "DescribeDBSnapshots": {
        const filterId = params.get("DBSnapshotIdentifier");
        let list = Array.from(snapshots.values());
        if (filterId) list = list.filter((s) => s.DBSnapshotIdentifier === filterId);
        jsonReply(reply, { DBSnapshots: list });
        break;
      }

      case "RebootDBInstance": {
        const id = params.get("DBInstanceIdentifier") ?? "";
        const instance = instances.get(id);
        jsonReply(reply, { DBInstance: instance ?? {} });
        break;
      }

      default: {
        jsonReply(
          reply,
          {
            __type: "UnknownOperationException",
            message: `lws: RDS action '${action}' is not yet implemented`,
          },
          400,
        );
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
