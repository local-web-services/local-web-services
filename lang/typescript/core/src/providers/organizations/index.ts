/** AWS Organizations wire-protocol Fastify plugin (JSON API). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { createRequestContext, recordLog } from "../../middleware/logging";

const ACCOUNT_ID = "000000000000";
const TARGET_PREFIXES = ["AmazonOrganizationsV20161128.", "AWSOrganizationsV20161128."];

let orgCounter = 0;
let rootCounter = 0;
let ouCounter = 0;
let policyCounter = 0;
let accountCounter = 0;

function nextOrgId(): string {
  return `o-${(++orgCounter).toString(16).padStart(4, "0")}`;
}
function nextRootId(): string {
  return `r-${(++rootCounter).toString(16).padStart(4, "0")}`;
}
function nextOuId(): string {
  return `ou-${(++ouCounter).toString(16).padStart(8, "0")}`;
}
function nextPolicyId(): string {
  return `p-${(++policyCounter).toString(16).padStart(8, "0")}`;
}
function nextAccountId(): string {
  return String(++accountCounter).padStart(12, "0");
}

function orgArn(orgId: string): string {
  return `arn:aws:organizations::${ACCOUNT_ID}:organization/${orgId}`;
}
function rootArn(orgId: string, rootId: string): string {
  return `arn:aws:organizations::${ACCOUNT_ID}:root/${orgId}/${rootId}`;
}
function ouArn(orgId: string, ouId: string): string {
  return `arn:aws:organizations::${ACCOUNT_ID}:ou/${orgId}/${ouId}`;
}
function accountArn(accountId: string): string {
  return `arn:aws:organizations::${ACCOUNT_ID}:account/${accountId}`;
}
function policyArn(orgId: string, policyId: string): string {
  return `arn:aws:organizations::${ACCOUNT_ID}:policy/${orgId}/service_control_policy/${policyId}`;
}

type Rec = Record<string, unknown>;

export class OrganizationsStore {
  organization: Rec | null = null;
  root: Rec | null = null;
  ous: Map<string, Rec> = new Map();
  accounts: Map<string, Rec> = new Map();
  accountParents: Map<string, string> = new Map();
  policies: Map<string, Rec> = new Map();
  policyAttachments: Map<string, Set<string>> = new Map();

  reset(): void {
    this.organization = null;
    this.root = null;
    this.ous.clear();
    this.accounts.clear();
    this.accountParents.clear();
    this.policies.clear();
    this.policyAttachments.clear();
  }

  parentExists(parentId: string): boolean {
    if (this.root && this.root["Id"] === parentId) return true;
    return this.ous.has(parentId);
  }

  targetType(targetId: string): string | null {
    if (this.root && this.root["Id"] === targetId) return "ROOT";
    if (this.ous.has(targetId)) return "ORGANIZATIONAL_UNIT";
    if (this.accounts.has(targetId)) return "ACCOUNT";
    return null;
  }

  ouHasChildren(ouId: string): boolean {
    for (const parentId of this.accountParents.values()) {
      if (parentId === ouId) return true;
    }
    for (const ou of this.ous.values()) {
      if (ou["ParentId"] === ouId) return true;
    }
    return false;
  }

  ouHasAttachedPolicies(ouId: string): boolean {
    for (const targets of this.policyAttachments.values()) {
      if (targets.has(ouId)) return true;
    }
    return false;
  }
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

export function registerOrganizations(
  app: FastifyInstance,
  state: ServerState,
): OrganizationsStore {
  const store = new OrganizationsStore();
  state.resetCallbacks.push(() => store.reset());

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    let operation = target;
    for (const prefix of TARGET_PREFIXES) {
      if (target.startsWith(prefix)) {
        operation = target.slice(prefix.length);
        break;
      }
    }
    const body = (req.body ?? {}) as Rec;
    const ctx = createRequestContext("organizations", operation);

    if (await applyChaos(state, "organizations", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "organizations", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    handleOrganizationsOp(operation, body, store, reply);
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

function str(body: Rec, key: string): string {
  return (body[key] as string) ?? "";
}

function handleOrganizationsOp(
  operation: string,
  body: Rec,
  store: OrganizationsStore,
  reply: FastifyReply,
): void {
  switch (operation) {
    case "CreateOrganization": {
      if (store.organization !== null) {
        jsonReply(
          reply,
          {
            __type: "AlreadyInOrganizationException",
            message: "The account is already a member of an organization.",
          },
          409,
        );
        return;
      }
      const featureSet = str(body, "FeatureSet") || "ALL";
      const orgId = nextOrgId();
      const rootId = nextRootId();
      const org = {
        Id: orgId,
        Arn: orgArn(orgId),
        FeatureSet: featureSet,
        MasterAccountId: ACCOUNT_ID,
        MasterAccountArn: `arn:aws:organizations::${ACCOUNT_ID}:account/${orgId}/${ACCOUNT_ID}`,
        MasterAccountEmail: "master@example.com",
        AvailablePolicyTypes: [{ Type: "SERVICE_CONTROL_POLICY", Status: "ENABLED" }],
      };
      const root = {
        Id: rootId,
        Arn: rootArn(orgId, rootId),
        Name: "Root",
        PolicyTypes: [{ Type: "SERVICE_CONTROL_POLICY", Status: "ENABLED" }],
      };
      store.organization = org;
      store.root = root;
      jsonReply(reply, { Organization: org });
      break;
    }
    case "DescribeOrganization": {
      if (!store.organization) {
        jsonReply(
          reply,
          {
            __type: "AWSOrganizationsNotInUseException",
            message: "Your account is not a member of an organization.",
          },
          400,
        );
        return;
      }
      jsonReply(reply, { Organization: store.organization });
      break;
    }
    case "ListRoots": {
      jsonReply(reply, { Roots: store.root ? [store.root] : [] });
      break;
    }
    case "CreateAccount": {
      if (!store.organization) {
        jsonReply(
          reply,
          {
            __type: "AWSOrganizationsNotInUseException",
            message: "Your account is not a member of an organization.",
          },
          400,
        );
        return;
      }
      const email = str(body, "Email");
      for (const acct of store.accounts.values()) {
        if (acct["Email"] === email) {
          jsonReply(
            reply,
            {
              __type: "DuplicateAccountException",
              message: `An account with email '${email}' already exists.`,
            },
            409,
          );
          return;
        }
      }
      const accountId = nextAccountId();
      const name = str(body, "AccountName");
      const ts = Date.now() / 1000;
      const acct = {
        Id: accountId,
        Arn: accountArn(accountId),
        Name: name,
        Email: email,
        Status: "ACTIVE",
        JoinedMethod: "CREATED",
        JoinedTimestamp: ts,
      };
      store.accounts.set(accountId, acct);
      store.accountParents.set(accountId, store.root!["Id"] as string);
      jsonReply(reply, {
        CreateAccountStatus: {
          State: "SUCCEEDED",
          AccountId: accountId,
          AccountName: name,
          RequestedTimestamp: ts,
        },
      });
      break;
    }
    case "DescribeAccount": {
      const accountId = str(body, "AccountId");
      const acct = store.accounts.get(accountId);
      if (!acct) {
        jsonReply(
          reply,
          { __type: "AccountNotFoundException", message: `Account '${accountId}' does not exist.` },
          400,
        );
        return;
      }
      jsonReply(reply, { Account: acct });
      break;
    }
    case "ListAccounts": {
      jsonReply(reply, { Accounts: Array.from(store.accounts.values()) });
      break;
    }
    case "ListAccountsForParent": {
      const parentId = str(body, "ParentId");
      const accts = Array.from(store.accounts.entries())
        .filter(([id]) => store.accountParents.get(id) === parentId)
        .map(([, a]) => a);
      jsonReply(reply, { Accounts: accts });
      break;
    }
    case "CreateOrganizationalUnit": {
      if (!store.organization) {
        jsonReply(
          reply,
          {
            __type: "AWSOrganizationsNotInUseException",
            message: "Your account is not a member of an organization.",
          },
          400,
        );
        return;
      }
      const parentId = str(body, "ParentId");
      const name = str(body, "Name");
      if (!store.parentExists(parentId)) {
        jsonReply(
          reply,
          { __type: "ParentNotFoundException", message: `Parent '${parentId}' does not exist.` },
          400,
        );
        return;
      }
      for (const ou of store.ous.values()) {
        if (ou["ParentId"] === parentId && ou["Name"] === name) {
          jsonReply(
            reply,
            {
              __type: "DuplicateOrganizationalUnitException",
              message: `An OU named '${name}' already exists under parent '${parentId}'.`,
            },
            409,
          );
          return;
        }
      }
      const orgId = store.organization["Id"] as string;
      const ouId = nextOuId();
      const ou = { Id: ouId, Arn: ouArn(orgId, ouId), Name: name, ParentId: parentId };
      store.ous.set(ouId, ou);
      jsonReply(reply, { OrganizationalUnit: ou });
      break;
    }
    case "DescribeOrganizationalUnit": {
      const ouId = str(body, "OrganizationalUnitId");
      const ou = store.ous.get(ouId);
      if (!ou) {
        jsonReply(
          reply,
          {
            __type: "OrganizationalUnitNotFoundException",
            message: `Organizational unit '${ouId}' does not exist.`,
          },
          400,
        );
        return;
      }
      jsonReply(reply, { OrganizationalUnit: ou });
      break;
    }
    case "ListOrganizationalUnitsForParent": {
      const parentId = str(body, "ParentId");
      const ous = Array.from(store.ous.values()).filter((o) => o["ParentId"] === parentId);
      jsonReply(reply, { OrganizationalUnits: ous });
      break;
    }
    case "DeleteOrganizationalUnit": {
      const ouId = str(body, "OrganizationalUnitId");
      if (!store.ous.has(ouId)) {
        jsonReply(
          reply,
          {
            __type: "OrganizationalUnitNotFoundException",
            message: `Organizational unit '${ouId}' does not exist.`,
          },
          400,
        );
        return;
      }
      if (store.ouHasChildren(ouId)) {
        jsonReply(
          reply,
          {
            __type: "OrganizationalUnitNotEmptyException",
            message: `Organizational unit '${ouId}' is not empty.`,
          },
          400,
        );
        return;
      }
      if (store.ouHasAttachedPolicies(ouId)) {
        jsonReply(
          reply,
          {
            __type: "PolicyChangesInProgressException",
            message: `Organizational unit '${ouId}' has policies attached.`,
          },
          400,
        );
        return;
      }
      store.ous.delete(ouId);
      jsonReply(reply, {});
      break;
    }
    case "MoveAccount": {
      const accountId = str(body, "AccountId");
      const srcId = str(body, "SourceParentId");
      const dstId = str(body, "DestinationParentId");
      if (!store.accounts.has(accountId)) {
        jsonReply(
          reply,
          { __type: "AccountNotFoundException", message: `Account '${accountId}' does not exist.` },
          400,
        );
        return;
      }
      if (store.accountParents.get(accountId) !== srcId) {
        jsonReply(
          reply,
          {
            __type: "SourceParentNotFoundException",
            message: `Account '${accountId}' is not under source parent '${srcId}'.`,
          },
          400,
        );
        return;
      }
      if (!store.parentExists(dstId)) {
        jsonReply(
          reply,
          {
            __type: "DestinationParentNotFoundException",
            message: `Destination parent '${dstId}' does not exist.`,
          },
          400,
        );
        return;
      }
      store.accountParents.set(accountId, dstId);
      jsonReply(reply, {});
      break;
    }
    case "CreatePolicy": {
      if (!store.organization) {
        jsonReply(
          reply,
          {
            __type: "AWSOrganizationsNotInUseException",
            message: "Your account is not a member of an organization.",
          },
          400,
        );
        return;
      }
      const name = str(body, "Name");
      const polType = str(body, "Type") || "SERVICE_CONTROL_POLICY";
      for (const pol of store.policies.values()) {
        const summary = pol["PolicySummary"] as Rec;
        if (summary["Name"] === name && summary["Type"] === polType) {
          jsonReply(
            reply,
            {
              __type: "DuplicatePolicyException",
              message: `A policy named '${name}' of type '${polType}' already exists.`,
            },
            409,
          );
          return;
        }
      }
      const orgId = store.organization["Id"] as string;
      const policyId = nextPolicyId();
      const policy = {
        PolicySummary: {
          Id: policyId,
          Arn: policyArn(orgId, policyId),
          Name: name,
          Description: str(body, "Description"),
          Type: polType,
          AwsManaged: false,
        },
        Content: str(body, "Content") || "{}",
      };
      store.policies.set(policyId, policy);
      jsonReply(reply, { Policy: policy });
      break;
    }
    case "DescribePolicy": {
      const policyId = str(body, "PolicyId");
      const pol = store.policies.get(policyId);
      if (!pol) {
        jsonReply(
          reply,
          { __type: "PolicyNotFoundException", message: `Policy '${policyId}' does not exist.` },
          400,
        );
        return;
      }
      jsonReply(reply, { Policy: pol });
      break;
    }
    case "ListPolicies": {
      const filter = str(body, "Filter");
      const policies = Array.from(store.policies.values())
        .map((p) => p["PolicySummary"] as Rec)
        .filter((s) => !filter || s["Type"] === filter);
      jsonReply(reply, { Policies: policies });
      break;
    }
    case "AttachPolicy": {
      const policyId = str(body, "PolicyId");
      const targetId = str(body, "TargetId");
      if (!store.policies.has(policyId)) {
        jsonReply(
          reply,
          { __type: "PolicyNotFoundException", message: `Policy '${policyId}' does not exist.` },
          400,
        );
        return;
      }
      if (!store.targetType(targetId)) {
        jsonReply(
          reply,
          { __type: "TargetNotFoundException", message: `Target '${targetId}' does not exist.` },
          400,
        );
        return;
      }
      if (!store.policyAttachments.has(policyId)) store.policyAttachments.set(policyId, new Set());
      const targets = store.policyAttachments.get(policyId)!;
      if (targets.has(targetId)) {
        jsonReply(
          reply,
          {
            __type: "DuplicatePolicyAttachmentException",
            message: `Policy '${policyId}' is already attached to target '${targetId}'.`,
          },
          409,
        );
        return;
      }
      targets.add(targetId);
      jsonReply(reply, {});
      break;
    }
    case "DetachPolicy": {
      const policyId = str(body, "PolicyId");
      const targetId = str(body, "TargetId");
      if (!store.policyAttachments.get(policyId)?.has(targetId)) {
        jsonReply(
          reply,
          {
            __type: "PolicyNotAttachedException",
            message: `Policy '${policyId}' is not attached to target '${targetId}'.`,
          },
          400,
        );
        return;
      }
      store.policyAttachments.get(policyId)!.delete(targetId);
      jsonReply(reply, {});
      break;
    }
    case "ListPoliciesForTarget": {
      const targetId = str(body, "TargetId");
      const filter = str(body, "Filter");
      const policies: Rec[] = [];
      for (const [polId, targets] of store.policyAttachments) {
        if (!targets.has(targetId)) continue;
        const pol = store.policies.get(polId);
        if (!pol) continue;
        const summary = pol["PolicySummary"] as Rec;
        if (filter && summary["Type"] !== filter) continue;
        policies.push(summary);
      }
      jsonReply(reply, { Policies: policies });
      break;
    }
    case "ListTargetsForPolicy": {
      const policyId = str(body, "PolicyId");
      if (!store.policies.has(policyId)) {
        jsonReply(
          reply,
          { __type: "PolicyNotFoundException", message: `Policy '${policyId}' does not exist.` },
          400,
        );
        return;
      }
      const targets = Array.from(store.policyAttachments.get(policyId) ?? [])
        .map((id) => ({ TargetId: id, Type: store.targetType(id) }))
        .filter((t) => t.Type !== null);
      jsonReply(reply, { Targets: targets });
      break;
    }
    default:
      jsonReply(
        reply,
        {
          __type: "InvalidAction",
          message: `lws: Organizations operation '${operation}' is not yet implemented`,
        },
        400,
      );
  }
}
