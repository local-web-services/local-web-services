package io.localwebservices.lws.providers.cognitoidp;

import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** Handles Cognito IDP user pool and user pool client operations. */
class CognitoIdpPoolOps {

  private static final String REGION = "us-east-1";
  private static final String ACCOUNT = "000000000000";

  private final CognitoIdpStore store;
  private final CognitoIdpHelpers helpers;

  CognitoIdpPoolOps(CognitoIdpStore store, CognitoIdpHelpers helpers) {
    this.store = store;
    this.helpers = helpers;
  }

  boolean handle(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateUserPool":
        {
          String name = (String) body.get("PoolName");
          boolean poolNameExists =
              store.pools.values().stream().anyMatch(p -> name.equals(p.get("Name")));
          if (poolNameExists) {
            helpers.sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceConflictException",
                    "message",
                    "Pool already exists"));
            return true;
          }
          String id = REGION + "_" + CognitoIdpHelpers.uuid9();
          double now = CognitoIdpHelpers.nowSeconds();
          Map<String, Object> pool = new LinkedHashMap<>();
          pool.put("Id", id);
          pool.put("Name", name);
          pool.put("Arn", "arn:aws:cognito-idp:" + REGION + ":" + ACCOUNT + ":userpool/" + id);
          pool.put("Status", "Active");
          pool.put("CreationDate", now);
          pool.put("LastModifiedDate", now);
          store.pools.put(id, pool);
          store.users.put(id, new ConcurrentHashMap<>());
          store.groups.put(id, new ConcurrentHashMap<>());
          store.groupMembers.put(id, new ConcurrentHashMap<>());
          helpers.sendJson(exchange, 200, Map.of("UserPool", pool));
          return true;
        }
      case "DeleteUserPool":
        {
          String poolId = (String) body.get("UserPoolId");
          helpers.requirePool(poolId);
          store.pools.remove(poolId);
          store.users.remove(poolId);
          store.groups.remove(poolId);
          store.groupMembers.remove(poolId);
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "DescribeUserPool":
        {
          String poolId = (String) body.get("UserPoolId");
          helpers.sendJson(exchange, 200, Map.of("UserPool", helpers.requirePool(poolId)));
          return true;
        }
      case "ListUserPools":
        {
          List<Map<String, Object>> list = new ArrayList<>();
          for (Map<String, Object> p : store.pools.values()) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("Id", p.get("Id"));
            entry.put("Name", p.get("Name"));
            entry.put("Status", p.get("Status"));
            entry.put("CreationDate", p.get("CreationDate"));
            entry.put("LastModifiedDate", p.get("LastModifiedDate"));
            list.add(entry);
          }
          helpers.sendJson(exchange, 200, Map.of("UserPools", list));
          return true;
        }
      case "UpdateUserPool":
        {
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "CreateUserPoolClient":
        {
          String poolId = (String) body.get("UserPoolId");
          helpers.requirePool(poolId);
          String clientName = (String) body.get("ClientName");
          String clientId = CognitoIdpHelpers.uuid26();
          double now = CognitoIdpHelpers.nowSeconds();
          Map<String, Object> client = new LinkedHashMap<>();
          client.put("ClientId", clientId);
          client.put("ClientName", clientName);
          client.put("UserPoolId", poolId);
          client.put("CreationDate", now);
          client.put("LastModifiedDate", now);
          store.clients.put(clientId, client);
          helpers.sendJson(exchange, 200, Map.of("UserPoolClient", client));
          return true;
        }
      case "DescribeUserPoolClient":
        {
          String clientId = (String) body.get("ClientId");
          Map<String, Object> client = store.clients.get(clientId);
          if (client == null) {
            helpers.sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFoundException",
                    "message",
                    "Client not found: " + clientId));
            return true;
          }
          helpers.sendJson(exchange, 200, Map.of("UserPoolClient", client));
          return true;
        }
      case "DeleteUserPoolClient":
        {
          String clientId = (String) body.get("ClientId");
          store.clients.remove(clientId);
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "UpdateUserPoolClient":
      case "ListUserPoolClients":
        {
          helpers.sendJson(exchange, 200, Map.of("UserPoolClients", List.of()));
          return true;
        }
      default:
        return false;
    }
  }
}
