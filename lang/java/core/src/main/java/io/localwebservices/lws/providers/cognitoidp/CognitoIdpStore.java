package io.localwebservices.lws.providers.cognitoidp;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory Cognito IDP state storage. */
public class CognitoIdpStore {

  // Pool storage: poolId → pool attributes
  public final Map<String, Map<String, Object>> pools = new ConcurrentHashMap<>();
  // Users: poolId → username → user
  public final Map<String, Map<String, Map<String, Object>>> users = new ConcurrentHashMap<>();
  // Groups: poolId → groupName → group
  public final Map<String, Map<String, Map<String, Object>>> groups = new ConcurrentHashMap<>();
  // Group members: poolId → groupName → Set<username>
  public final Map<String, Map<String, Set<String>>> groupMembers = new ConcurrentHashMap<>();
  // Clients: clientId → client attributes
  public final Map<String, Map<String, Object>> clients = new ConcurrentHashMap<>();
  // Auth sessions: session → session attributes
  public final Map<String, Map<String, Object>> authSessions = new ConcurrentHashMap<>();

  public void reset() {
    pools.clear();
    users.clear();
    groups.clear();
    groupMembers.clear();
    clients.clear();
    authSessions.clear();
  }
}
