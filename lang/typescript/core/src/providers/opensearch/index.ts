/** OpenSearch wire-protocol Fastify plugin (REST/JSON protocol, path-based routing). */

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

interface OutboundConnection {
  ConnectionId: string;
  ConnectionAlias: string;
  ConnectionStatus: { StatusCode: string };
  LocalDomainInfo: unknown;
  RemoteDomainInfo: unknown;
}

interface InboundConnection {
  ConnectionId: string;
  ConnectionStatus: { StatusCode: string };
  LocalDomainInfo: unknown;
  RemoteDomainInfo: unknown;
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
  if (await applyIamAuth(state, "opensearch", operation, req, reply)) return true;
  if (await applyChaos(state, "opensearch", operation, req, reply)) return true;
  if (await applyFake(state, "opensearch", operation, req, reply)) return true;
  return false;
}

let connectionCounter = 0;

export function registerOpenSearch(app: FastifyInstance, state: ServerState): void {
  const domains = new Map<string, OpenSearchDomain>();
  const outboundConnections = new Map<string, OutboundConnection>();
  const inboundConnections = new Map<string, InboundConnection>();

  state.resetCallbacks.push(() => {
    domains.clear();
    outboundConnections.clear();
    inboundConnections.clear();
    connectionCounter = 0;
  });

  // POST /2021-01-01/opensearch/domain → CreateDomain
  app.post("/2021-01-01/opensearch/domain", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "CreateDomain";
    const ctx = createRequestContext("opensearch", operation);
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
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // DELETE /2021-01-01/opensearch/domain/:DomainName → DeleteDomain
  app.delete(
    "/2021-01-01/opensearch/domain/:DomainName",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DeleteDomain";
      const ctx = createRequestContext("opensearch", operation);
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

  // GET /2021-01-01/opensearch/domain/:DomainName → DescribeDomain
  app.get(
    "/2021-01-01/opensearch/domain/:DomainName",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DescribeDomain";
      const ctx = createRequestContext("opensearch", operation);
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

  // GET /2021-01-01/opensearch/domain/:DomainName/config → DescribeDomainConfig
  app.get(
    "/2021-01-01/opensearch/domain/:DomainName/config",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "DescribeDomainConfig";
      const ctx = createRequestContext("opensearch", operation);
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
          EngineVersion: { Options: domain.EngineVersion, Status: { State: "Active" } },
          ClusterConfig: { Options: domain.ClusterConfig, Status: { State: "Active" } },
        },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // POST /2021-01-01/opensearch/domain/:DomainName/config → UpdateDomainConfig
  app.post(
    "/2021-01-01/opensearch/domain/:DomainName/config",
    async (req: FastifyRequest<{ Params: { DomainName: string } }>, reply: FastifyReply) => {
      const operation = "UpdateDomainConfig";
      const ctx = createRequestContext("opensearch", operation);
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
          EngineVersion: { Options: domain.EngineVersion, Status: { State: "Processing" } },
          ClusterConfig: { Options: domain.ClusterConfig, Status: { State: "Processing" } },
        },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // GET /2021-01-01/domain → ListDomainNames
  app.get("/2021-01-01/domain", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "ListDomainNames";
    const ctx = createRequestContext("opensearch", operation);
    if (await applyMiddleware(state, operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    jsonReply(reply, {
      DomainNames: Array.from(domains.values()).map((d) => ({ DomainName: d.DomainName })),
    });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // POST /2021-01-01/tags → AddTags
  app.post("/2021-01-01/tags", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "AddTags";
    const ctx = createRequestContext("opensearch", operation);
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

  // GET /2021-01-01/tags → ListTags (ARN via query param, lowercase "arn")
  app.get(
    "/2021-01-01/tags",
    async (
      req: FastifyRequest<{ Querystring: { ARN?: string; arn?: string } }>,
      reply: FastifyReply,
    ) => {
      const operation = "ListTags";
      const ctx = createRequestContext("opensearch", operation);
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

  // POST /2021-01-01/tags-removal → RemoveTags
  app.post("/2021-01-01/tags-removal", async (req: FastifyRequest, reply: FastifyReply) => {
    const operation = "RemoveTags";
    const ctx = createRequestContext("opensearch", operation);
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

  // POST /2021-01-01/opensearch/cc/outboundConnection → CreateOutboundConnection
  app.post(
    "/2021-01-01/opensearch/cc/outboundConnection",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const operation = "CreateOutboundConnection";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const body = req.body as Record<string, unknown>;
      const localDomainInfo = body.LocalDomainInfo as Record<string, unknown>;
      const remoteDomainInfo = body.RemoteDomainInfo as Record<string, unknown>;
      const connectionAlias = body.ConnectionAlias as string;

      // Validate remote domain exists
      const remoteAwsDomainInfo = remoteDomainInfo?.AWSDomainInformation as
        | Record<string, unknown>
        | undefined;
      const remoteDomainName = remoteAwsDomainInfo?.DomainName as string | undefined;
      if (remoteDomainName && !domains.has(remoteDomainName)) {
        jsonReply(
          reply,
          {
            __type: "ResourceNotFoundException",
            message: `Remote domain ${remoteDomainName} not found`,
          },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const connectionId = `conn-${++connectionCounter}`;
      const outbound: OutboundConnection = {
        ConnectionId: connectionId,
        ConnectionAlias: connectionAlias,
        ConnectionStatus: { StatusCode: "PENDING_ACCEPTANCE" },
        LocalDomainInfo: localDomainInfo,
        RemoteDomainInfo: remoteDomainInfo,
      };
      outboundConnections.set(connectionId, outbound);

      // Create corresponding inbound connection on the remote side
      const inbound: InboundConnection = {
        ConnectionId: connectionId,
        ConnectionStatus: { StatusCode: "PENDING_ACCEPTANCE" },
        LocalDomainInfo: remoteDomainInfo,
        RemoteDomainInfo: localDomainInfo,
      };
      inboundConnections.set(connectionId, inbound);

      jsonReply(reply, { ...outbound });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // DELETE /2021-01-01/opensearch/cc/outboundConnection/:ConnectionId → DeleteOutboundConnection
  app.delete(
    "/2021-01-01/opensearch/cc/outboundConnection/:ConnectionId",
    async (req: FastifyRequest<{ Params: { ConnectionId: string } }>, reply: FastifyReply) => {
      const operation = "DeleteOutboundConnection";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const id = req.params.ConnectionId;
      const conn = outboundConnections.get(id);
      outboundConnections.delete(id);
      inboundConnections.delete(id);
      jsonReply(reply, {
        Connection: conn
          ? { ...conn, ConnectionStatus: { StatusCode: "DELETED" } }
          : { ConnectionId: id, ConnectionStatus: { StatusCode: "DELETED" } },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // PUT /2021-01-01/opensearch/cc/inboundConnection/:ConnectionId/accept → AcceptInboundConnection
  app.put(
    "/2021-01-01/opensearch/cc/inboundConnection/:ConnectionId/accept",
    async (req: FastifyRequest<{ Params: { ConnectionId: string } }>, reply: FastifyReply) => {
      const operation = "AcceptInboundConnection";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const id = req.params.ConnectionId;
      const conn = inboundConnections.get(id);
      if (!conn) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Connection ${id} not found` },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      conn.ConnectionStatus = { StatusCode: "ACTIVE" };
      const outbound = outboundConnections.get(id);
      if (outbound) outbound.ConnectionStatus = { StatusCode: "ACTIVE" };
      jsonReply(reply, { Connection: conn });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // PUT /2021-01-01/opensearch/cc/inboundConnection/:ConnectionId/reject → RejectInboundConnection
  app.put(
    "/2021-01-01/opensearch/cc/inboundConnection/:ConnectionId/reject",
    async (req: FastifyRequest<{ Params: { ConnectionId: string } }>, reply: FastifyReply) => {
      const operation = "RejectInboundConnection";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const id = req.params.ConnectionId;
      const conn = inboundConnections.get(id);
      if (!conn) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Connection ${id} not found` },
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      conn.ConnectionStatus = { StatusCode: "REJECTED" };
      const outbound = outboundConnections.get(id);
      if (outbound) outbound.ConnectionStatus = { StatusCode: "REJECTED" };
      inboundConnections.delete(id);
      jsonReply(reply, { Connection: conn });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // DELETE /2021-01-01/opensearch/cc/inboundConnection/:ConnectionId → DeleteInboundConnection
  app.delete(
    "/2021-01-01/opensearch/cc/inboundConnection/:ConnectionId",
    async (req: FastifyRequest<{ Params: { ConnectionId: string } }>, reply: FastifyReply) => {
      const operation = "DeleteInboundConnection";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const id = req.params.ConnectionId;
      const conn = inboundConnections.get(id);
      inboundConnections.delete(id);
      outboundConnections.delete(id);
      jsonReply(reply, {
        Connection: conn
          ? { ...conn, ConnectionStatus: { StatusCode: "DELETED" } }
          : { ConnectionId: id, ConnectionStatus: { StatusCode: "DELETED" } },
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // POST /2021-01-01/opensearch/cc/inboundConnection/search → DescribeInboundConnections
  app.post(
    "/2021-01-01/opensearch/cc/inboundConnection/search",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const operation = "DescribeInboundConnections";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      jsonReply(reply, { Connections: Array.from(inboundConnections.values()) });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // POST /2021-01-01/opensearch/cc/outboundConnection/search → DescribeOutboundConnections
  app.post(
    "/2021-01-01/opensearch/cc/outboundConnection/search",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const operation = "DescribeOutboundConnections";
      const ctx = createRequestContext("opensearch", operation);
      if (await applyMiddleware(state, operation, req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      jsonReply(reply, { Connections: Array.from(outboundConnections.values()) });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );
}
