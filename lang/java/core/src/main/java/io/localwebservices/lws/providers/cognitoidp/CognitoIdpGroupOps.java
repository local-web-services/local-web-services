package io.localwebservices.lws.providers.cognitoidp;

import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.util.*;

/** Handles Cognito IDP group operations. */
class CognitoIdpGroupOps {

  private final CognitoIdpStore store;
  private final CognitoIdpHelpers helpers;

  CognitoIdpGroupOps(CognitoIdpStore store, CognitoIdpHelpers helpers) {
    this.store = store;
    this.helpers = helpers;
  }

  boolean handle(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          helpers.requirePool(poolId);
          String groupName = (String) body.get("GroupName");
          Map<String, Map<String, Object>> poolGroups = store.groups.get(poolId);
          if (poolGroups.containsKey(groupName)) {
            throw new IllegalArgumentException(
                "GroupExistsException: Group " + groupName + " already exists");
          }
          double now = CognitoIdpHelpers.nowSeconds();
          Map<String, Object> group = new LinkedHashMap<>();
          group.put("GroupName", groupName);
          group.put("UserPoolId", poolId);
          group.put("Description", body.getOrDefault("Description", ""));
          group.put("Precedence", body.getOrDefault("Precedence", 0));
          group.put("CreationDate", now);
          group.put("LastModifiedDate", now);
          poolGroups.put(groupName, group);
          store.groupMembers.get(poolId).put(groupName, new HashSet<>());
          helpers.sendJson(exchange, 200, Map.of("Group", group));
          return true;
        }
      case "DeleteGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          String groupName = (String) body.get("GroupName");
          Map<String, Map<String, Object>> poolGroups = store.groups.get(poolId);
          if (poolGroups == null || !poolGroups.containsKey(groupName)) {
            throw new IllegalArgumentException(
                "ResourceNotFoundException: Group " + groupName + " not found");
          }
          poolGroups.remove(groupName);
          store.groupMembers.get(poolId).remove(groupName);
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "GetGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          String groupName = (String) body.get("GroupName");
          Map<String, Object> group = helpers.requireGroup(poolId, groupName);
          helpers.sendJson(exchange, 200, Map.of("Group", group));
          return true;
        }
      case "ListGroups":
        {
          String poolId = (String) body.get("UserPoolId");
          helpers.requirePool(poolId);
          List<Map<String, Object>> groupList = new ArrayList<>(store.groups.get(poolId).values());
          helpers.sendJson(exchange, 200, Map.of("Groups", groupList));
          return true;
        }
      case "AdminAddUserToGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          String groupName = (String) body.get("GroupName");
          helpers.requireUser(poolId, username);
          helpers.requireGroup(poolId, groupName);
          store.groupMembers.get(poolId).get(groupName).add(username);
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "AdminRemoveUserFromGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          String groupName = (String) body.get("GroupName");
          Set<String> members = store.groupMembers.getOrDefault(poolId, Map.of()).get(groupName);
          if (members != null) members.remove(username);
          helpers.sendJson(exchange, 200, Map.of());
          return true;
        }
      case "ListUsersInGroup":
        {
          String poolId = (String) body.get("UserPoolId");
          String groupName = (String) body.get("GroupName");
          helpers.requireGroup(poolId, groupName);
          Set<String> members = store.groupMembers.get(poolId).getOrDefault(groupName, Set.of());
          Map<String, Map<String, Object>> poolUsers = helpers.requirePoolUsers(poolId);
          List<Map<String, Object>> userList = new ArrayList<>();
          for (String username : members) {
            Map<String, Object> u = poolUsers.get(username);
            if (u != null) userList.add(CognitoIdpHelpers.formatUserShort(u));
          }
          helpers.sendJson(exchange, 200, Map.of("Users", userList));
          return true;
        }
      case "AdminListGroupsForUser":
        {
          String poolId = (String) body.get("UserPoolId");
          String username = (String) body.get("Username");
          helpers.requireUser(poolId, username);
          List<Map<String, Object>> userGroups = new ArrayList<>();
          Map<String, Set<String>> poolGroupMembers = store.groupMembers.get(poolId);
          if (poolGroupMembers != null) {
            for (Map.Entry<String, Set<String>> entry : poolGroupMembers.entrySet()) {
              if (entry.getValue().contains(username)) {
                Map<String, Object> g = store.groups.get(poolId).get(entry.getKey());
                if (g != null) userGroups.add(g);
              }
            }
          }
          helpers.sendJson(exchange, 200, Map.of("Groups", userGroups));
          return true;
        }
      default:
        return false;
    }
  }
}
