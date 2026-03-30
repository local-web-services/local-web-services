/** Elasticsearch wire-protocol Fastify plugin (REST/JSON protocol, path-based routing). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface ElasticsearchDomain {
  DomainName: string;
  ARN: string;
  DomainId: string;
  Created: boolean;
  Deleted: boolean;
  Processing: boolean;
  ElasticsearchVersion: string;
  ElasticsearchClusterConfig: {
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

async function applyMiddleware(
  state: ServerState,
  operation: string,
  req: FastifyRequest,
  reply: FastifyReply,
): Promise<boolean> {
  if (await applyIamAuth(state, "elasticsearch", operation, req, reply)) return true;
  if (await applyChaos(state, "elasticsearch", operation, req, reply)) return true;
  if (await applyFake(state, "elasticsearch", operation, req, reply)) return true;
  return false;
}

export function registerElasticsearch(app: FastifyInstance, state: ServerState): void {
  const domains = new Map<string, ElasticsearchDomain>();

  state.resetCallbacks.push(() => {
    domains.clear();
  });

  // POST /2015-01-01/es/domain → CreateElasticsearchDomain
  app.post("/2015-01-01/es/domain", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "CreateElasticsearchDomain";
    const ctx = createRequestContext("elasticsearch", operation);
    if (await applyMiddleware(state, operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const body = req.body as Record<string, unknown>;
    const name = body.DomainName as string;
    if (domains.has(name)) {
      jsonReply(
        reply,
        { __type: "ResourceAlreadyExistsException", message: `Domain ${name} already exists` },
        409,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const domain: ElasticsearchDomain = {
      DomainName: name,
      ARN: `arn:aws:es:${REGION}:${ACCOUNT_ID}:domain/${name}`,
      DomainId: `${ACCOUNT_ID}/${name}`,
      Created: true,
      Deleted: false,
      Processing: false,
      ElasticsearchVersion: (body.ElasticsearchVersion as string) ?? "7.10",
      ElasticsearchClusterConfig: {
        InstanceType: "m4.large.elasticsearch",
        InstanceCount: 1,
        DedicatedMasterEnabled: false,
        ZoneAwarenessEnabled: false,
      },
      Endpoint: `http://localhost:9200`,
      Tags: {},
    };
    domains.set(name, domain);
    jsonReply(reply, { DomainStatus: domain });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // DELETE /2015-01-01/es/domain/:DomainName → DeleteElasticsearchDomain
  app.delete(
    "/2015-01-01/es/domain/:DomainName",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DeleteElasticsearchDomain";
      const ctx = createRequestContext("elasticsearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const name = req.params.DomainName;
      const domain = domains.get(name);
      domains.delete(name);
      jsonReply(reply, { DomainStatus: domain ?? {} });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // GET /2015-01-01/es/domain/:DomainName → DescribeElasticsearchDomain
  app.get(
    "/2015-01-01/es/domain/:DomainName",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DescribeElasticsearchDomain";
      const ctx = createRequestContext("elasticsearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const name = req.params.DomainName;
      const domain = domains.get(name);
      if (!domain) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Domain ${name} not found` },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      jsonReply(reply, { DomainStatus: domain });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // GET /2015-01-01/es/domain/:DomainName/config → DescribeElasticsearchDomainConfig
  app.get(
    "/2015-01-01/es/domain/:DomainName/config",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DescribeElasticsearchDomainConfig";
      const ctx = createRequestContext("elasticsearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const name = req.params.DomainName;
      const domain = domains.get(name);
      if (!domain) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Domain ${name} not found` },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      jsonReply(reply, {
        DomainConfig: {
          ElasticsearchVersion: {
            Options: domain.ElasticsearchVersion,
            Status: { State: "Active" },
          },
          ElasticsearchClusterConfig: {
            Options: domain.ElasticsearchClusterConfig,
            Status: { State: "Active" },
          },
        },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // POST /2015-01-01/es/domain/:DomainName/config → UpdateElasticsearchDomainConfig
  app.post(
    "/2015-01-01/es/domain/:DomainName/config",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "UpdateElasticsearchDomainConfig";
      const ctx = createRequestContext("elasticsearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const name = req.params.DomainName;
      const domain = domains.get(name);
      if (!domain) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Domain ${name} not found` },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      domain.Processing = true;
      jsonReply(reply, {
        DomainConfig: {
          ElasticsearchVersion: {
            Options: domain.ElasticsearchVersion,
            Status: { State: "Processing" },
          },
          ElasticsearchClusterConfig: {
            Options: domain.ElasticsearchClusterConfig,
            Status: { State: "Processing" },
          },
        },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // GET /2015-01-01/domain → ListDomainNames
  app.get("/2015-01-01/domain", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "ListDomainNames";
    const ctx = createRequestContext("elasticsearch", operation);
    if (await applyMiddleware(state, operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    jsonReply(reply, {
      DomainNames: Array.from(domains.values()).map((d) => ({ DomainName: d.DomainName })),
    });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // POST /2015-01-01/tags → AddTags
  app.post("/2015-01-01/tags", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "AddTags";
    const ctx = createRequestContext("elasticsearch", operation);
    if (await applyMiddleware(state, operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const body = req.body as Record<string, unknown>;
    const arn = body.ARN as string;
    const tagList = (body.TagList as Array<{ Key: string; Value: string }>) ?? [];
    const name = arn.split("/").pop() ?? "";
    const domain = domains.get(name);
    if (!domain) {
      jsonReply(
        reply,
        { __type: "ResourceNotFoundException", message: `Domain ${name} not found` },
        409,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    for (const tag of tagList) domain.Tags[tag.Key] = tag.Value;
    jsonReply(reply, {});
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // GET /2015-01-01/tags → ListTags (ARN via query param, lowercase "arn")
  app.get(
    "/2015-01-01/tags",
    async (
      req: FastifyRequest<{ Querystring: { ARN?: string; arn?: string } }>,
      reply: FastifyReply,
    ) => {
      const operation = "ListTags";
      const ctx = createRequestContext("elasticsearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const arn = req.query.arn ?? req.query.ARN ?? "";
      const name = arn.split("/").pop() ?? "";
      const domain = domains.get(name);
      const tagList = domain
        ? Object.entries(domain.Tags).map(([Key, Value]) => ({ Key, Value }))
        : [];
      jsonReply(reply, { TagList: tagList });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // POST /2015-01-01/tags-removal → RemoveTags
  app.post("/2015-01-01/tags-removal", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "RemoveTags";
    const ctx = createRequestContext("elasticsearch", operation);
    if (await applyMiddleware(state, operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const body = req.body as Record<string, unknown>;
    const arn = body.ARN as string;
    const tagKeys = (body.TagKeys as string[]) ?? [];
    const name = arn.split("/").pop() ?? "";
    const domain = domains.get(name);
    if (!domain) {
      jsonReply(
        reply,
        { __type: "ResourceNotFoundException", message: `Domain ${name} not found` },
        409,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const missingKey = tagKeys.find((k) => !(k in domain.Tags));
    if (missingKey !== undefined) {
      jsonReply(
        reply,
        {
          __type: "ValidationException",
          message: `Tag key ${missingKey} does not exist on domain ${name}`,
        },
        400,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    for (const key of tagKeys) delete domain.Tags[key];
    jsonReply(reply, {});
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });
}
