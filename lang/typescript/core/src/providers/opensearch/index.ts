/** OpenSearch wire-protocol Fastify plugin (JSON protocol, X-Amz-Target). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface OpenSearchDomain {
  DomainName: string;
  ARN: string;
  DomainId: string;
  Created: boolean;
  Deleted: boolean;
  Processing: boolean;
  EngineVersion: string;
  ClusterConfig: {
    InstanceType: string;
    InstanceCount: number;
    DedicatedMasterEnabled: boolean;
    ZoneAwarenessEnabled: boolean;
  };
  Endpoint: string;
  Tags: Record<string, string>;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
}

const TARGET_PREFIX = "OpenSearch_20210101.";

export function registerOpenSearch(app: FastifyInstance, state: ServerState): void {
  const domains = new Map<string, OpenSearchDomain>();

  state.resetCallbacks.push(() => {
    domains.clear();
  });

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    const operation = target.startsWith(TARGET_PREFIX)
      ? target.slice(TARGET_PREFIX.length)
      : target;
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("opensearch", operation);

    if (await applyIamAuth(state, "opensearch", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "opensearch", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "opensearch", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    switch (operation) {
      case "CreateDomain": {
        const name = body.DomainName as string;
        const domain: OpenSearchDomain = {
          DomainName: name,
          ARN: `arn:aws:es:${REGION}:${ACCOUNT_ID}:domain/${name}`,
          DomainId: `${ACCOUNT_ID}/${name}`,
          Created: true,
          Deleted: false,
          Processing: false,
          EngineVersion: (body.EngineVersion as string) ?? "OpenSearch_2.5",
          ClusterConfig: {
            InstanceType: "m5.large.search",
            InstanceCount: 1,
            DedicatedMasterEnabled: false,
            ZoneAwarenessEnabled: false,
          },
          Endpoint: `http://localhost:9200`,
          Tags: {},
        };
        domains.set(name, domain);
        jsonReply(reply, { DomainStatus: domain });
        break;
      }

      case "DeleteDomain": {
        const name = body.DomainName as string;
        const domain = domains.get(name);
        domains.delete(name);
        jsonReply(reply, { DomainStatus: domain ?? {} });
        break;
      }

      case "DescribeDomain": {
        const name = body.DomainName as string;
        const domain = domains.get(name);
        if (!domain) {
          jsonReply(reply, { message: `Domain ${name} not found` }, 404);
          return;
        }
        jsonReply(reply, { DomainStatus: domain });
        break;
      }

      case "ListDomainNames": {
        jsonReply(reply, {
          DomainNames: Array.from(domains.values()).map((d) => ({ DomainName: d.DomainName })),
        });
        break;
      }

      case "AddTags": {
        const arn = body.ARN as string;
        const tagList = (body.TagList as Array<{ Key: string; Value: string }>) ?? [];
        const name = arn.split("/").pop() ?? "";
        const domain = domains.get(name);
        if (domain) {
          for (const tag of tagList) domain.Tags[tag.Key] = tag.Value;
        }
        jsonReply(reply, {});
        break;
      }

      case "ListTags": {
        const arn = body.ARN as string;
        const name = arn.split("/").pop() ?? "";
        const domain = domains.get(name);
        const tagList = domain
          ? Object.entries(domain.Tags).map(([Key, Value]) => ({ Key, Value }))
          : [];
        jsonReply(reply, { TagList: tagList });
        break;
      }

      case "RemoveTags": {
        const arn = body.ARN as string;
        const tagKeys = (body.TagKeys as string[]) ?? [];
        const name = arn.split("/").pop() ?? "";
        const domain = domains.get(name);
        if (domain) {
          for (const key of tagKeys) delete domain.Tags[key];
        }
        jsonReply(reply, {});
        break;
      }

      default: {
        jsonReply(
          reply,
          {
            __type: "UnknownOperationException",
            message: `lws: OpenSearch operation '${operation}' is not yet implemented`,
          },
          400,
        );
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
