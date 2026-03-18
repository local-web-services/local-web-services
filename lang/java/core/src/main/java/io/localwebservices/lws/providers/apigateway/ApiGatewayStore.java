package io.localwebservices.lws.providers.apigateway;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory API Gateway state storage. */
public class ApiGatewayStore {

  // apiId -> RestAPI
  public final Map<String, Map<String, Object>> apis = new ConcurrentHashMap<>();
  // apiId -> resourceId -> resource
  public final Map<String, Map<String, Map<String, Object>>> resources = new ConcurrentHashMap<>();
  // apiId -> deploymentId -> deployment
  public final Map<String, Map<String, Map<String, Object>>> deployments =
      new ConcurrentHashMap<>();
  // apiId -> stageName -> stage
  public final Map<String, Map<String, Map<String, Object>>> stages = new ConcurrentHashMap<>();

  public void reset() {
    apis.clear();
    resources.clear();
    deployments.clear();
    stages.clear();
  }

  /** Generates a short random ID suitable for API Gateway resource IDs. */
  public static String shortId() {
    return UUID.randomUUID().toString().replace("-", "").substring(0, 10);
  }
}
