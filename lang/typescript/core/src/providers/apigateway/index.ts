/** API Gateway REST wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import { isExhausted } from "../../types";
import { ApiGatewayStore } from "./store";

function errorReply(reply: FastifyReply, msg: string): void {
  // Parse error type from message prefix
  if (msg.includes("ConflictException:")) {
    reply
      .status(409)
      .header("Content-Type", "application/json")
      .send({
        __type: "ConflictException",
        message: msg.replace("ConflictException: ", ""),
      });
  } else if (msg.includes("BadRequestException:")) {
    reply
      .status(400)
      .header("Content-Type", "application/json")
      .send({
        __type: "BadRequestException",
        message: msg.replace("BadRequestException: ", ""),
      });
  } else {
    reply
      .status(404)
      .header("Content-Type", "application/json")
      .send({
        __type: "NotFoundException",
        message: msg.replace("NotFoundException: ", ""),
      });
  }
}

function notFound(reply: FastifyReply, msg: string): void {
  errorReply(reply, msg);
}

function log(state: ServerState, op: string, req: FastifyRequest, reply: FastifyReply): void {
  const ctx = createRequestContext("apigateway", op);
  recordLog(state, ctx, req.method, req.url, reply.statusCode);
}

export function registerApiGateway(app: FastifyInstance, state: ServerState): ApiGatewayStore {
  const store = new ApiGatewayStore();
  state.resetCallbacks.push(() => store.reset());

  // ── REST APIs ──────────────────────────────────────────────────────────────

  app.post("/restapis", async (req: FastifyRequest, reply: FastifyReply) => {
    if (await applyIamAuth(state, "apigateway", "CreateRestApi", req, reply)) {
      log(state, "CreateRestApi", req, reply);
      return;
    }
    if (await applyChaos(state, "apigateway", "CreateRestApi", req, reply)) {
      log(state, "CreateRestApi", req, reply);
      return;
    }
    if (await applyFake(state, "apigateway", "CreateRestApi", req, reply)) {
      log(state, "CreateRestApi", req, reply);
      return;
    }
    if (isExhausted(state.capacityConfigs["apigateway"] ?? { slots: null })) {
      reply.status(429).header("Content-Type", "application/json").send({
        __type: "LimitExceededException",
        message: "Maximum number of rest APIs per account reached",
      });
      log(state, "CreateRestApi", req, reply);
      return;
    }
    const body = (req.body as Record<string, unknown>) ?? {};
    // Check for duplicate name
    const existingApis = store.listRestApis();
    const requestedName = body.name as string;
    if (existingApis.some((a) => a.name === requestedName)) {
      reply
        .status(409)
        .header("Content-Type", "application/json")
        .send({
          __type: "ConflictException",
          message: `REST API with name "${requestedName}" already exists`,
        });
      log(state, "CreateRestApi", req, reply);
      return;
    }
    const api = store.createRestApi(
      body.name as string,
      body.description as string,
      (body.tags as Record<string, string>) ?? {},
    );
    reply.status(201).header("Content-Type", "application/json").send(api);
    log(state, "CreateRestApi", req, reply);
  });

  app.get("/restapis", async (req: FastifyRequest, reply: FastifyReply) => {
    reply.header("Content-Type", "application/json").send({ item: store.listRestApis() });
    log(state, "GetRestApis", req, reply);
  });

  app.get("/restapis/:apiId", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    const api = store.getRestApi(apiId);
    if (!api) {
      notFound(reply, `Rest API ${apiId} not found`);
      log(state, "GetRestApi", req, reply);
      return;
    }
    reply.header("Content-Type", "application/json").send(api);
    log(state, "GetRestApi", req, reply);
  });

  app.delete("/restapis/:apiId", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    try {
      store.deleteRestApi(apiId);
      reply.status(202).send();
    } catch {
      notFound(reply, `Rest API ${apiId} not found`);
    }
    log(state, "DeleteRestApi", req, reply);
  });

  // ── Resources ──────────────────────────────────────────────────────────────

  app.get("/restapis/:apiId/resources", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    try {
      reply.header("Content-Type", "application/json").send({ item: store.getResources(apiId) });
    } catch {
      notFound(reply, `Rest API ${apiId} not found`);
    }
    log(state, "GetResources", req, reply);
  });

  app.get(
    "/restapis/:apiId/resources/:resourceId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId } = req.params as { apiId: string; resourceId: string };
      const resource = store.getResource(apiId, resourceId);
      if (!resource) {
        notFound(reply, `Resource ${resourceId} not found`);
        log(state, "GetResource", req, reply);
        return;
      }
      reply.header("Content-Type", "application/json").send(resource);
      log(state, "GetResource", req, reply);
    },
  );

  app.post(
    "/restapis/:apiId/resources/:parentId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, parentId } = req.params as { apiId: string; parentId: string };
      const body = (req.body as Record<string, unknown>) ?? {};
      try {
        const resource = store.createResource(apiId, parentId, body.pathPart as string);
        reply.status(201).header("Content-Type", "application/json").send(resource);
      } catch (err) {
        notFound(reply, (err as Error).message);
      }
      log(state, "CreateResource", req, reply);
    },
  );

  app.delete(
    "/restapis/:apiId/resources/:resourceId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId } = req.params as { apiId: string; resourceId: string };
      try {
        store.deleteResource(apiId, resourceId);
        reply.status(202).send();
      } catch {
        notFound(reply, `Resource ${resourceId} not found`);
      }
      log(state, "DeleteResource", req, reply);
    },
  );

  // ── Methods ────────────────────────────────────────────────────────────────

  app.put(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      const body = (req.body as Record<string, unknown>) ?? {};
      try {
        const method = store.putMethod(
          apiId,
          resourceId,
          httpMethod,
          body.authorizationType as string,
          body.apiKeyRequired as boolean,
        );
        reply.status(201).header("Content-Type", "application/json").send(method);
      } catch (err) {
        notFound(reply, (err as Error).message);
      }
      log(state, "PutMethod", req, reply);
    },
  );

  app.get(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      const method = store.getMethod(apiId, resourceId, httpMethod);
      if (!method) {
        notFound(reply, `Method ${httpMethod} not found`);
        log(state, "GetMethod", req, reply);
        return;
      }
      reply.header("Content-Type", "application/json").send(method);
      log(state, "GetMethod", req, reply);
    },
  );

  app.delete(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      try {
        store.deleteMethod(apiId, resourceId, httpMethod);
        reply.status(204).send();
      } catch {
        notFound(reply, `Method ${httpMethod} not found`);
      }
      log(state, "DeleteMethod", req, reply);
    },
  );

  app.put(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod/responses/:statusCode",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod, statusCode } = req.params as Record<string, string>;
      try {
        const response = store.putMethodResponse(apiId, resourceId, httpMethod, statusCode);
        reply.status(201).header("Content-Type", "application/json").send(response);
      } catch (err) {
        notFound(reply, (err as Error).message);
      }
      log(state, "PutMethodResponse", req, reply);
    },
  );

  // ── Integrations ───────────────────────────────────────────────────────────

  app.put(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod/integration",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      const body = (req.body as Record<string, unknown>) ?? {};
      try {
        const integration = store.putIntegration(
          apiId,
          resourceId,
          httpMethod,
          body.type as string,
          body.uri as string,
          body.httpMethod as string,
        );
        reply.status(201).header("Content-Type", "application/json").send(integration);
      } catch (err) {
        notFound(reply, (err as Error).message);
      }
      log(state, "PutIntegration", req, reply);
    },
  );

  app.get(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod/integration",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      const integration = store.getIntegration(apiId, resourceId, httpMethod);
      if (!integration) {
        notFound(reply, `Integration not found`);
        log(state, "GetIntegration", req, reply);
        return;
      }
      reply.header("Content-Type", "application/json").send(integration);
      log(state, "GetIntegration", req, reply);
    },
  );

  app.delete(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod/integration",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod } = req.params as {
        apiId: string;
        resourceId: string;
        httpMethod: string;
      };
      try {
        store.deleteIntegration(apiId, resourceId, httpMethod);
        reply.status(204).send();
      } catch {
        notFound(reply, `Integration not found`);
      }
      log(state, "DeleteIntegration", req, reply);
    },
  );

  app.put(
    "/restapis/:apiId/resources/:resourceId/methods/:httpMethod/integration/responses/:statusCode",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, resourceId, httpMethod, statusCode } = req.params as Record<string, string>;
      try {
        const response = store.putIntegrationResponse(apiId, resourceId, httpMethod, statusCode);
        reply.status(201).header("Content-Type", "application/json").send(response);
      } catch (err) {
        notFound(reply, (err as Error).message);
      }
      log(state, "PutIntegrationResponse", req, reply);
    },
  );

  // ── Deployments ────────────────────────────────────────────────────────────

  app.post("/restapis/:apiId/deployments", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    const body = (req.body as Record<string, unknown>) ?? {};
    try {
      const deployment = store.createDeployment(
        apiId,
        body.description as string,
        body.stageName as string | undefined,
      );
      reply.status(201).header("Content-Type", "application/json").send(deployment);
    } catch (err) {
      notFound(reply, (err as Error).message);
    }
    log(state, "CreateDeployment", req, reply);
  });

  app.get("/restapis/:apiId/deployments", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    try {
      reply.header("Content-Type", "application/json").send({ item: store.listDeployments(apiId) });
    } catch (err) {
      notFound(reply, (err as Error).message);
    }
    log(state, "GetDeployments", req, reply);
  });

  app.get(
    "/restapis/:apiId/deployments/:deploymentId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, deploymentId } = req.params as { apiId: string; deploymentId: string };
      const deployment = store.getDeployment(apiId, deploymentId);
      if (!deployment) {
        notFound(reply, `Deployment ${deploymentId} not found`);
        log(state, "GetDeployment", req, reply);
        return;
      }
      reply.header("Content-Type", "application/json").send(deployment);
      log(state, "GetDeployment", req, reply);
    },
  );

  app.delete(
    "/restapis/:apiId/deployments/:deploymentId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, deploymentId } = req.params as { apiId: string; deploymentId: string };
      try {
        store.deleteDeployment(apiId, deploymentId);
        reply.status(202).send();
      } catch {
        notFound(reply, `Deployment ${deploymentId} not found`);
      }
      log(state, "DeleteDeployment", req, reply);
    },
  );

  // ── Stages ─────────────────────────────────────────────────────────────────

  app.post("/restapis/:apiId/stages", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    const body = (req.body as Record<string, unknown>) ?? {};
    try {
      const stage = store.createStage(
        apiId,
        body.stageName as string,
        body.deploymentId as string,
        (body.description as string) ?? "",
      );
      reply.status(201).header("Content-Type", "application/json").send(stage);
    } catch (err) {
      notFound(reply, (err as Error).message);
    }
    log(state, "CreateStage", req, reply);
  });

  app.get("/restapis/:apiId/stages", async (req: FastifyRequest, reply: FastifyReply) => {
    const { apiId } = req.params as { apiId: string };
    try {
      reply.header("Content-Type", "application/json").send({ item: store.listStages(apiId) });
    } catch (err) {
      notFound(reply, (err as Error).message);
    }
    log(state, "GetStages", req, reply);
  });

  app.get(
    "/restapis/:apiId/stages/:stageName",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, stageName } = req.params as { apiId: string; stageName: string };
      const stage = store.getStage(apiId, stageName);
      if (!stage) {
        notFound(reply, `Stage ${stageName} not found`);
        log(state, "GetStage", req, reply);
        return;
      }
      reply.header("Content-Type", "application/json").send(stage);
      log(state, "GetStage", req, reply);
    },
  );

  app.delete(
    "/restapis/:apiId/stages/:stageName",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, stageName } = req.params as { apiId: string; stageName: string };
      try {
        store.deleteStage(apiId, stageName);
        reply.status(202).send();
      } catch {
        notFound(reply, `Stage ${stageName} not found`);
      }
      log(state, "DeleteStage", req, reply);
    },
  );

  app.patch(
    "/restapis/:apiId/stages/:stageName",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { apiId, stageName } = req.params as { apiId: string; stageName: string };
      const body = (req.body as Record<string, unknown>) ?? {};
      // Process patchOperations format: [{ op: "replace", path: "/fieldName", value: "..." }]
      const patchOps =
        (body.patchOperations as Array<{ op: string; path: string; value: string }>) ?? [];
      const updates: Record<string, unknown> = {};
      for (const op of patchOps) {
        if (op.op === "replace" && op.path) {
          const field = op.path.replace(/^\//, "");
          updates[field] = op.value;
        }
      }
      // Also allow direct field updates (for backwards compat)
      const directUpdates = patchOps.length > 0 ? updates : (body as Record<string, unknown>);
      try {
        const stage = store.updateStage(apiId, stageName, directUpdates as any);
        reply.header("Content-Type", "application/json").send(stage);
      } catch {
        notFound(reply, `Stage ${stageName} not found`);
      }
      log(state, "UpdateStage", req, reply);
    },
  );

  return store;
}
