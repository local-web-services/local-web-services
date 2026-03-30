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

interface Tag {
  Key: string;
  Value: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

function errorReply(reply: FastifyReply, type: string, message: string): void {
  jsonReply(reply, { __type: type, message }, 400);
}

function resolvedStatus(
  resourceType: string,
  resourceId: string,
  actualStatus: string,
  state: ServerState,
): string {
  const injected = state.injectedStates.get(`memorydb:${resourceType}:${resourceId}`);
  return injected !== undefined ? injected : actualStatus;
}

const TARGET_PREFIX = "AmazonMemoryDB.";

export function registerMemoryDb(app: FastifyInstance, state: ServerState): void {
  const clusters = new Map<string, Cluster>();
  const users = new Map<string, MemoryDBUser>();
  const acls = new Map<string, ACL>();
  const snapshots = new Map<string, Snapshot>();
  const tags = new Map<string, Tag[]>();

  state.resetCallbacks.push(() => {
    clusters.clear();
    users.clear();
    acls.clear();
    snapshots.clear();
    tags.clear();
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
        if (clusters.has(name)) {
          errorReply(reply, "ClusterAlreadyExistsFault", `Cluster ${name} already exists`);
          break;
        }
        const snapshotName = body.SnapshotName as string | undefined;
        if (snapshotName !== undefined && !snapshots.has(snapshotName)) {
          errorReply(reply, "SnapshotNotFoundFault", `Snapshot ${snapshotName} not found`);
          break;
        }
        const arn = `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:cluster/${name}`;
        const cluster: Cluster = {
          Name: name,
          Status: "available",
          NumberOfShards: (body.NumShards as number) ?? 1,
          AvailabilityMode: "MultiAZ",
          ClusterEndpoint: { Address: `clustercfg.${name}.memorydb.localhost`, Port: 6379 },
          NodeType: (body.NodeType as string) ?? "db.r6g.large",
          EngineVersion: (body.EngineVersion as string) ?? "7.0",
          ARN: arn,
          ACLName: (body.ACLName as string) ?? "open-access",
        };
        clusters.set(name, cluster);
        const incomingTags = (body.Tags as Tag[]) ?? [];
        if (incomingTags.length > 0) {
          tags.set(arn, incomingTags);
        }
        // Return "creating" in the response to model the transitional state the client sees
        jsonReply(reply, { Cluster: { ...cluster, Status: "creating" } });
        break;
      }

      case "DeleteCluster": {
        const name = body.ClusterName as string;
        const cluster = clusters.get(name);
        if (!cluster) {
          errorReply(reply, "ClusterNotFoundFault", `Cluster ${name} not found`);
          break;
        }
        cluster.Status = "deleting";
        state.injectedStates.delete(`memorydb:cluster:${name}`);
        jsonReply(reply, { Cluster: cluster });
        break;
      }

      case "UpdateCluster": {
        const name = body.ClusterName as string;
        const cluster = clusters.get(name);
        if (!cluster) {
          errorReply(reply, "ClusterNotFoundFault", `Cluster ${name} not found`);
          break;
        }
        cluster.Status = "modifying";
        state.injectedStates.delete(`memorydb:cluster:${name}`);
        if (body.ACLName !== undefined) {
          cluster.ACLName = body.ACLName as string;
        }
        jsonReply(reply, { Cluster: cluster });
        break;
      }

      case "DescribeClusters": {
        const filterName = body.ClusterName as string | undefined;
        let list = Array.from(clusters.values());
        if (filterName) list = list.filter((c) => c.Name === filterName);
        const resolvedList = list.map((c) => ({
          ...c,
          Status: resolvedStatus("cluster", c.Name, c.Status, state),
        }));
        jsonReply(reply, { Clusters: resolvedList });
        break;
      }

      case "CreateUser": {
        const name = body.UserName as string;
        if (users.has(name)) {
          errorReply(reply, "UserAlreadyExistsFault", `User ${name} already exists`);
          break;
        }
        const arn = `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:user/${name}`;
        const user: MemoryDBUser = {
          Name: name,
          Status: "creating",
          AccessString: (body.AccessString as string) ?? "on ~* &* +@all",
          ARN: arn,
          ACLNames: [],
        };
        users.set(name, user);
        const incomingTags = (body.Tags as Tag[]) ?? [];
        if (incomingTags.length > 0) {
          tags.set(arn, incomingTags);
        }
        jsonReply(reply, { User: user });
        break;
      }

      case "DeleteUser": {
        const name = body.UserName as string;
        const user = users.get(name);
        if (!user) {
          errorReply(reply, "UserNotFoundFault", `User ${name} not found`);
          break;
        }
        user.Status = "deleting";
        state.injectedStates.delete(`memorydb:user:${name}`);
        jsonReply(reply, { User: user });
        break;
      }

      case "UpdateUser": {
        const name = body.UserName as string;
        const user = users.get(name);
        if (!user) {
          errorReply(reply, "UserNotFoundFault", `User ${name} not found`);
          break;
        }
        user.Status = "modifying";
        state.injectedStates.delete(`memorydb:user:${name}`);
        if (body.AccessString !== undefined) {
          user.AccessString = body.AccessString as string;
        }
        jsonReply(reply, { User: user });
        break;
      }

      case "DescribeUsers": {
        const filterName = body.UserName as string | undefined;
        let list = Array.from(users.values());
        if (filterName) list = list.filter((u) => u.Name === filterName);
        const resolvedList = list.map((u) => ({
          ...u,
          Status: resolvedStatus("user", u.Name, u.Status, state),
        }));
        jsonReply(reply, { Users: resolvedList });
        break;
      }

      case "CreateACL": {
        const name = body.ACLName as string;
        if (acls.has(name)) {
          errorReply(reply, "ACLAlreadyExistsFault", `ACL ${name} already exists`);
          break;
        }
        const arn = `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:acl/${name}`;
        const acl: ACL = {
          Name: name,
          Status: "creating",
          UserNames: (body.UserNames as string[]) ?? [],
          ARN: arn,
        };
        acls.set(name, acl);
        const incomingTags = (body.Tags as Tag[]) ?? [];
        if (incomingTags.length > 0) {
          tags.set(arn, incomingTags);
        }
        jsonReply(reply, { ACL: acl });
        break;
      }

      case "DeleteACL": {
        const name = body.ACLName as string;
        const acl = acls.get(name);
        if (!acl) {
          errorReply(reply, "ACLNotFoundFault", `ACL ${name} not found`);
          break;
        }
        acl.Status = "deleting";
        state.injectedStates.delete(`memorydb:acl:${name}`);
        jsonReply(reply, { ACL: acl });
        break;
      }

      case "UpdateACL": {
        const name = body.ACLName as string;
        const acl = acls.get(name);
        if (!acl) {
          errorReply(reply, "ACLNotFoundFault", `ACL ${name} not found`);
          break;
        }
        const userNamesToAdd = (body.UserNamesToAdd as string[]) ?? [];
        const userNamesToRemove = (body.UserNamesToRemove as string[]) ?? [];

        for (const userName of userNamesToAdd) {
          if (!users.has(userName)) {
            errorReply(reply, "UserNotFoundFault", `User ${userName} not found`);
            return;
          }
          if (acl.UserNames.includes(userName)) {
            errorReply(
              reply,
              "DuplicateUserNameFault",
              `User ${userName} is already a member of ACL ${name}`,
            );
            return;
          }
          acl.UserNames.push(userName);
        }

        for (const userName of userNamesToRemove) {
          const idx = acl.UserNames.indexOf(userName);
          if (idx === -1) {
            errorReply(
              reply,
              "UserNotFoundFault",
              `User ${userName} is not a member of ACL ${name}`,
            );
            return;
          }
          acl.UserNames.splice(idx, 1);
        }

        acl.Status = "modifying";
        state.injectedStates.delete(`memorydb:acl:${name}`);
        jsonReply(reply, { ACL: acl });
        break;
      }

      case "DescribeACLs": {
        const filterName = body.ACLName as string | undefined;
        let list = Array.from(acls.values());
        if (filterName) list = list.filter((a) => a.Name === filterName);
        const resolvedList = list.map((a) => ({
          ...a,
          Status: resolvedStatus("acl", a.Name, a.Status, state),
        }));
        jsonReply(reply, { ACLs: resolvedList });
        break;
      }

      case "CreateSnapshot": {
        const name = body.SnapshotName as string;
        const clusterName = body.ClusterName as string;
        const cluster = clusters.get(clusterName);
        if (!cluster) {
          errorReply(reply, "ClusterNotFoundFault", `Cluster ${clusterName} not found`);
          break;
        }
        const arn = `arn:aws:memorydb:${REGION}:${ACCOUNT_ID}:snapshot/${name}`;
        const snap: Snapshot = {
          Name: name,
          Status: "creating",
          ClusterConfiguration: { Name: clusterName },
          ARN: arn,
        };
        snapshots.set(name, snap);
        cluster.Status = "snapshotting";
        state.injectedStates.delete(`memorydb:cluster:${clusterName}`);
        const incomingTags = (body.Tags as Tag[]) ?? [];
        if (incomingTags.length > 0) {
          tags.set(arn, incomingTags);
        }
        jsonReply(reply, { Snapshot: snap });
        break;
      }

      case "DeleteSnapshot": {
        const name = body.SnapshotName as string;
        const snap = snapshots.get(name);
        if (!snap) {
          errorReply(reply, "SnapshotNotFoundFault", `Snapshot ${name} not found`);
          break;
        }
        snap.Status = "deleting";
        state.injectedStates.delete(`memorydb:snapshot:${name}`);
        jsonReply(reply, { Snapshot: snap });
        break;
      }

      case "DescribeSnapshots": {
        const filterName = body.SnapshotName as string | undefined;
        let list = Array.from(snapshots.values());
        if (filterName) list = list.filter((s) => s.Name === filterName);
        const resolvedList = list.map((s) => ({
          ...s,
          Status: resolvedStatus("snapshot", s.Name, s.Status, state),
        }));
        jsonReply(reply, { Snapshots: resolvedList });
        break;
      }

      case "TagResource": {
        const resourceArn = body.ResourceArn as string;
        const incomingTags = (body.Tags as Tag[]) ?? [];
        const resourceExists =
          Array.from(clusters.values()).some((c) => c.ARN === resourceArn) ||
          Array.from(users.values()).some((u) => u.ARN === resourceArn) ||
          Array.from(acls.values()).some((a) => a.ARN === resourceArn) ||
          Array.from(snapshots.values()).some((s) => s.ARN === resourceArn);
        if (!resourceExists) {
          errorReply(reply, "ResourceNotFoundFault", `Resource ${resourceArn} not found`);
          break;
        }
        const existing = tags.get(resourceArn);
        if (!existing || existing.length === 0) {
          errorReply(
            reply,
            "InvalidParameterValueException",
            `Resource ${resourceArn} has no existing tags`,
          );
          break;
        }
        const merged = [...existing];
        for (const tag of incomingTags) {
          const idx = merged.findIndex((t) => t.Key === tag.Key);
          if (idx >= 0) {
            merged[idx] = tag;
          } else {
            merged.push(tag);
          }
        }
        tags.set(resourceArn, merged);
        jsonReply(reply, { TagList: merged });
        break;
      }

      case "UntagResource": {
        const resourceArn = body.ResourceArn as string;
        const tagKeys = (body.TagKeys as string[]) ?? [];
        const resourceExists =
          Array.from(clusters.values()).some((c) => c.ARN === resourceArn) ||
          Array.from(users.values()).some((u) => u.ARN === resourceArn) ||
          Array.from(acls.values()).some((a) => a.ARN === resourceArn) ||
          Array.from(snapshots.values()).some((s) => s.ARN === resourceArn);
        if (!resourceExists) {
          errorReply(reply, "ResourceNotFoundFault", `Resource ${resourceArn} not found`);
          break;
        }
        const existing = tags.get(resourceArn);
        if (!existing || existing.length === 0) {
          errorReply(
            reply,
            "InvalidParameterValueException",
            `Resource ${resourceArn} has no existing tags`,
          );
          break;
        }
        const updated = existing.filter((t) => !tagKeys.includes(t.Key));
        tags.set(resourceArn, updated);
        jsonReply(reply, { TagList: updated });
        break;
      }

      case "ListTags": {
        const resourceArn = body.ResourceArn as string;
        const resourceExists =
          Array.from(clusters.values()).some((c) => c.ARN === resourceArn) ||
          Array.from(users.values()).some((u) => u.ARN === resourceArn) ||
          Array.from(acls.values()).some((a) => a.ARN === resourceArn) ||
          Array.from(snapshots.values()).some((s) => s.ARN === resourceArn);
        if (!resourceExists) {
          errorReply(reply, "ResourceNotFoundFault", `Resource ${resourceArn} not found`);
          break;
        }
        const tagList = tags.get(resourceArn) ?? [];
        jsonReply(reply, { TagList: tagList });
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
