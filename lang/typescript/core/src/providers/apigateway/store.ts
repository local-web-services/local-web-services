/** API Gateway in-memory store. */

import { v4 as uuidv4 } from "uuid";

const REGION = "us-east-1";

export interface RestApi {
  id: string;
  name: string;
  description: string;
  createdDate: number;
  tags: Record<string, string>;
}

export interface ApiResource {
  id: string;
  parentId: string | null;
  pathPart: string;
  path: string;
  resourceMethods: Record<string, ResourceMethod>;
}

export interface ResourceMethod {
  httpMethod: string;
  authorizationType: string;
  apiKeyRequired: boolean;
  requestParameters: Record<string, boolean>;
  methodIntegration?: MethodIntegration;
  methodResponses: Record<string, MethodResponse>;
}

export interface MethodIntegration {
  type: string;
  httpMethod: string;
  uri: string;
  passthroughBehavior: string;
  timeoutInMillis: number;
  integrationResponses: Record<string, IntegrationResponse>;
}

export interface IntegrationResponse {
  statusCode: string;
  responseTemplates: Record<string, string>;
}

export interface MethodResponse {
  statusCode: string;
  responseModels: Record<string, string>;
}

export interface Deployment {
  id: string;
  description: string;
  createdDate: number;
  stageName?: string;
}

export interface Stage {
  stageName: string;
  deploymentId: string;
  description: string;
  createdDate: number;
  lastUpdatedDate: number;
  variables: Record<string, string>;
  defaultRouteSettings?: {
    throttlingBurstLimit?: number;
    throttlingRateLimit?: number;
  };
  tags: Record<string, string>;
}

export class ApiGatewayStore {
  private apis: Map<string, RestApi> = new Map();
  private resources: Map<string, Map<string, ApiResource>> = new Map();
  private deployments: Map<string, Map<string, Deployment>> = new Map();
  private stages: Map<string, Map<string, Stage>> = new Map();

  reset(): void {
    this.apis.clear();
    this.resources.clear();
    this.deployments.clear();
    this.stages.clear();
  }

  // ── REST APIs ──────────────────────────────────────────────────────────────

  createRestApi(name: string, description: string, tags: Record<string, string>): RestApi {
    const id = uuidv4().replace(/-/g, "").slice(0, 10);
    const api: RestApi = {
      id,
      name,
      description: description ?? "",
      createdDate: Math.floor(Date.now() / 1000),
      tags: tags ?? {},
    };
    this.apis.set(id, api);
    // Create root resource "/"
    const rootResourceId = uuidv4().replace(/-/g, "").slice(0, 10);
    const rootResource: ApiResource = {
      id: rootResourceId,
      parentId: null,
      pathPart: "",
      path: "/",
      resourceMethods: {},
    };
    this.resources.set(id, new Map([[rootResourceId, rootResource]]));
    this.deployments.set(id, new Map());
    this.stages.set(id, new Map());
    return api;
  }

  getRestApi(id: string): RestApi | undefined {
    return this.apis.get(id);
  }

  listRestApis(): RestApi[] {
    return Array.from(this.apis.values());
  }

  deleteRestApi(id: string): void {
    if (!this.apis.has(id)) throw new Error(`NotFoundException: Rest API ${id} not found`);
    this.apis.delete(id);
    this.resources.delete(id);
    this.deployments.delete(id);
    this.stages.delete(id);
  }

  // ── Resources ──────────────────────────────────────────────────────────────

  getResources(apiId: string): ApiResource[] {
    const resourceMap = this.resources.get(apiId);
    if (!resourceMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    return Array.from(resourceMap.values());
  }

  getResource(apiId: string, resourceId: string): ApiResource | undefined {
    return this.resources.get(apiId)?.get(resourceId);
  }

  createResource(apiId: string, parentId: string, pathPart: string): ApiResource {
    const resourceMap = this.resources.get(apiId);
    if (!resourceMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    const parent = resourceMap.get(parentId);
    if (!parent) throw new Error(`NotFoundException: Parent resource ${parentId} not found`);
    const path = parent.path === "/" ? `/${pathPart}` : `${parent.path}/${pathPart}`;
    const id = uuidv4().replace(/-/g, "").slice(0, 10);
    const resource: ApiResource = { id, parentId, pathPart, path, resourceMethods: {} };
    resourceMap.set(id, resource);
    return resource;
  }

  deleteResource(apiId: string, resourceId: string): void {
    const resourceMap = this.resources.get(apiId);
    if (!resourceMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    if (!resourceMap.has(resourceId))
      throw new Error(`NotFoundException: Resource ${resourceId} not found`);
    resourceMap.delete(resourceId);
  }

  // ── Methods ────────────────────────────────────────────────────────────────

  putMethod(
    apiId: string,
    resourceId: string,
    httpMethod: string,
    authorizationType: string,
    apiKeyRequired: boolean,
  ): ResourceMethod {
    const resource = this.getResource(apiId, resourceId);
    if (!resource) throw new Error(`NotFoundException: Resource ${resourceId} not found`);
    const method: ResourceMethod = {
      httpMethod,
      authorizationType: authorizationType ?? "NONE",
      apiKeyRequired: apiKeyRequired ?? false,
      requestParameters: {},
      methodResponses: {},
    };
    resource.resourceMethods[httpMethod] = method;
    return method;
  }

  getMethod(apiId: string, resourceId: string, httpMethod: string): ResourceMethod | undefined {
    return this.getResource(apiId, resourceId)?.resourceMethods[httpMethod];
  }

  deleteMethod(apiId: string, resourceId: string, httpMethod: string): void {
    const resource = this.getResource(apiId, resourceId);
    if (!resource) throw new Error(`NotFoundException: Resource ${resourceId} not found`);
    delete resource.resourceMethods[httpMethod];
  }

  putMethodResponse(
    apiId: string,
    resourceId: string,
    httpMethod: string,
    statusCode: string,
  ): MethodResponse {
    const method = this.getMethod(apiId, resourceId, httpMethod);
    if (!method) throw new Error(`NotFoundException: Method ${httpMethod} not found`);
    const response: MethodResponse = { statusCode, responseModels: {} };
    method.methodResponses[statusCode] = response;
    return response;
  }

  // ── Integrations ───────────────────────────────────────────────────────────

  putIntegration(
    apiId: string,
    resourceId: string,
    httpMethod: string,
    type: string,
    uri: string,
    integrationHttpMethod: string,
  ): MethodIntegration {
    const method = this.getMethod(apiId, resourceId, httpMethod);
    if (!method) throw new Error(`NotFoundException: Method ${httpMethod} not found`);
    const integration: MethodIntegration = {
      type: type ?? "AWS_PROXY",
      httpMethod: integrationHttpMethod ?? "POST",
      uri: uri ?? "",
      passthroughBehavior: "WHEN_NO_MATCH",
      timeoutInMillis: 29000,
      integrationResponses: {},
    };
    method.methodIntegration = integration;
    return integration;
  }

  getIntegration(
    apiId: string,
    resourceId: string,
    httpMethod: string,
  ): MethodIntegration | undefined {
    return this.getMethod(apiId, resourceId, httpMethod)?.methodIntegration;
  }

  deleteIntegration(apiId: string, resourceId: string, httpMethod: string): void {
    const method = this.getMethod(apiId, resourceId, httpMethod);
    if (!method) throw new Error(`NotFoundException: Method ${httpMethod} not found`);
    delete method.methodIntegration;
  }

  putIntegrationResponse(
    apiId: string,
    resourceId: string,
    httpMethod: string,
    statusCode: string,
  ): IntegrationResponse {
    const integration = this.getIntegration(apiId, resourceId, httpMethod);
    if (!integration) throw new Error(`NotFoundException: Integration not found`);
    const response: IntegrationResponse = { statusCode, responseTemplates: {} };
    integration.integrationResponses[statusCode] = response;
    return response;
  }

  // ── Deployments ────────────────────────────────────────────────────────────

  createDeployment(apiId: string, description: string, stageName?: string): Deployment {
    const deploymentMap = this.deployments.get(apiId);
    if (!deploymentMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    const id = uuidv4().replace(/-/g, "").slice(0, 10);
    const deployment: Deployment = {
      id,
      description: description ?? "",
      createdDate: Math.floor(Date.now() / 1000),
      stageName,
    };
    deploymentMap.set(id, deployment);
    if (stageName) {
      this.createOrUpdateStage(apiId, stageName, id, description ?? "");
    }
    return deployment;
  }

  getDeployment(apiId: string, deploymentId: string): Deployment | undefined {
    return this.deployments.get(apiId)?.get(deploymentId);
  }

  listDeployments(apiId: string): Deployment[] {
    const deploymentMap = this.deployments.get(apiId);
    if (!deploymentMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    return Array.from(deploymentMap.values());
  }

  deleteDeployment(apiId: string, deploymentId: string): void {
    const deploymentMap = this.deployments.get(apiId);
    if (!deploymentMap || !deploymentMap.has(deploymentId)) {
      throw new Error(`NotFoundException: Deployment ${deploymentId} not found`);
    }
    deploymentMap.delete(deploymentId);
  }

  // ── Stages ─────────────────────────────────────────────────────────────────

  private createOrUpdateStage(
    apiId: string,
    stageName: string,
    deploymentId: string,
    description: string,
  ): Stage {
    const stageMap = this.stages.get(apiId)!;
    const existing = stageMap.get(stageName);
    if (existing) {
      existing.deploymentId = deploymentId;
      existing.lastUpdatedDate = Math.floor(Date.now() / 1000);
      return existing;
    }
    const stage: Stage = {
      stageName,
      deploymentId,
      description,
      createdDate: Math.floor(Date.now() / 1000),
      lastUpdatedDate: Math.floor(Date.now() / 1000),
      variables: {},
      tags: {},
    };
    stageMap.set(stageName, stage);
    return stage;
  }

  createStage(apiId: string, stageName: string, deploymentId: string, description: string): Stage {
    const stageMap = this.stages.get(apiId);
    if (!stageMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    return this.createOrUpdateStage(apiId, stageName, deploymentId, description);
  }

  getStage(apiId: string, stageName: string): Stage | undefined {
    return this.stages.get(apiId)?.get(stageName);
  }

  listStages(apiId: string): Stage[] {
    const stageMap = this.stages.get(apiId);
    if (!stageMap) throw new Error(`NotFoundException: Rest API ${apiId} not found`);
    return Array.from(stageMap.values());
  }

  deleteStage(apiId: string, stageName: string): void {
    const stageMap = this.stages.get(apiId);
    if (!stageMap || !stageMap.has(stageName)) {
      throw new Error(`NotFoundException: Stage ${stageName} not found`);
    }
    stageMap.delete(stageName);
  }

  updateStage(apiId: string, stageName: string, updates: Partial<Stage>): Stage {
    const stage = this.getStage(apiId, stageName);
    if (!stage) throw new Error(`NotFoundException: Stage ${stageName} not found`);
    if (updates.description !== undefined) stage.description = updates.description;
    if (updates.deploymentId !== undefined) stage.deploymentId = updates.deploymentId;
    if (updates.variables !== undefined) stage.variables = updates.variables;
    if (updates.defaultRouteSettings !== undefined)
      stage.defaultRouteSettings = updates.defaultRouteSettings;
    stage.lastUpdatedDate = Math.floor(Date.now() / 1000);
    return stage;
  }

  invokeUrl(apiId: string, stageName: string): string {
    return `http://127.0.0.1:0/restapis/${apiId}/${stageName}`;
  }

  arn(apiId: string): string {
    return `arn:aws:apigateway:${REGION}::/restapis/${apiId}`;
  }
}
