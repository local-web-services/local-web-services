package io.localwebservices.lws.providers.elasticache;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory ElastiCache storage. */
public class ElastiCacheStore {

  private final Map<String, Map<String, Object>> cacheClusters = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> replicationGroups = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> subnetGroups = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> parameterGroups = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> snapshots = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public void reset() {
    cacheClusters.clear();
    replicationGroups.clear();
    subnetGroups.clear();
    parameterGroups.clear();
    snapshots.clear();
    resourceTags.clear();
  }

  public List<Map<String, String>> addTagsToResource(
      String resourceName, List<Map<String, String>> tags) {
    List<Map<String, String>> existing =
        resourceTags.computeIfAbsent(resourceName, k -> new ArrayList<>());
    existing.addAll(tags);
    return existing;
  }

  public List<Map<String, String>> removeTagsFromResource(
      String resourceName, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(resourceName, new ArrayList<>());
    existing.removeIf(tag -> tagKeys.contains(tag.get("Key")));
    return existing;
  }

  public List<Map<String, String>> listTagsForResource(String resourceName) {
    return resourceTags.getOrDefault(resourceName, new ArrayList<>());
  }

  public Map<String, Object> createCacheCluster(Map<String, String> params) {
    String id = params.get("CacheClusterId");
    Map<String, Object> cluster = new LinkedHashMap<>();
    cluster.put("CacheClusterId", id);
    cluster.put("CacheClusterStatus", "available");
    cluster.put("Engine", params.getOrDefault("Engine", "redis"));
    cluster.put("EngineVersion", params.getOrDefault("EngineVersion", "7.0.7"));
    cluster.put("NumCacheNodes", Integer.parseInt(params.getOrDefault("NumCacheNodes", "1")));
    cluster.put("CacheNodeType", params.getOrDefault("CacheNodeType", "cache.t3.micro"));
    Map<String, Object> node = new LinkedHashMap<>();
    node.put("CacheNodeId", "0001");
    node.put("CacheNodeStatus", "available");
    node.put("Endpoint", Map.of("Address", "localhost", "Port", 6379));
    cluster.put("CacheNodes", List.of(node));
    cacheClusters.put(id, cluster);
    return cluster;
  }

  public Map<String, Object> deleteCacheCluster(String id) {
    return cacheClusters.remove(id);
  }

  public List<Map<String, Object>> describeCacheClusters(String id) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (id != null) {
      Map<String, Object> cluster = cacheClusters.get(id);
      if (cluster != null) list.add(cluster);
    } else {
      list.addAll(cacheClusters.values());
    }
    return list;
  }

  public Map<String, Object> createReplicationGroup(Map<String, String> params) {
    String id = params.get("ReplicationGroupId");
    Map<String, Object> rg = new LinkedHashMap<>();
    rg.put("ReplicationGroupId", id);
    rg.put("Status", "available");
    rg.put("Description", params.getOrDefault("ReplicationGroupDescription", ""));
    rg.put("MemberClusters", List.of(id + "-001"));
    Map<String, Object> nodeGroup = new LinkedHashMap<>();
    nodeGroup.put("NodeGroupId", "0001");
    nodeGroup.put("Status", "available");
    nodeGroup.put("PrimaryEndpoint", Map.of("Address", "localhost", "Port", 6379));
    rg.put("NodeGroups", List.of(nodeGroup));
    replicationGroups.put(id, rg);
    return rg;
  }

  public Map<String, Object> deleteReplicationGroup(String id) {
    return replicationGroups.remove(id);
  }

  public List<Map<String, Object>> describeReplicationGroups(String id) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (id != null) {
      Map<String, Object> rg = replicationGroups.get(id);
      if (rg != null) list.add(rg);
    } else {
      list.addAll(replicationGroups.values());
    }
    return list;
  }

  public Map<String, Object> modifyCacheCluster(String id) {
    Map<String, Object> cluster = cacheClusters.get(id);
    if (cluster == null) {
      throw new IllegalArgumentException("CacheCluster not found: " + id);
    }
    return cluster;
  }

  public Map<String, Object> modifyReplicationGroup(String id) {
    Map<String, Object> rg = replicationGroups.get(id);
    if (rg == null) {
      throw new IllegalArgumentException("ReplicationGroup not found: " + id);
    }
    return rg;
  }

  public Map<String, Object> createCacheParameterGroup(Map<String, String> params) {
    String name = params.get("CacheParameterGroupName");
    Map<String, Object> pg = new LinkedHashMap<>();
    pg.put("CacheParameterGroupName", name);
    pg.put("CacheParameterGroupFamily", params.getOrDefault("CacheParameterGroupFamily", ""));
    pg.put("Description", params.getOrDefault("Description", ""));
    parameterGroups.put(name, pg);
    return pg;
  }

  public void deleteCacheParameterGroup(String name) {
    parameterGroups.remove(name);
  }

  public Map<String, Object> createSnapshot(Map<String, String> params) {
    String name = params.get("SnapshotName");
    Map<String, Object> snap = new LinkedHashMap<>();
    snap.put("SnapshotName", name);
    snap.put("SnapshotStatus", "available");
    snap.put("CacheClusterId", params.getOrDefault("CacheClusterId", ""));
    snap.put("ReplicationGroupId", params.getOrDefault("ReplicationGroupId", ""));
    snap.put("Engine", "redis");
    snapshots.put(name, snap);
    return snap;
  }

  public Map<String, Object> deleteSnapshot(String name) {
    return snapshots.remove(name);
  }

  public Map<String, Object> createCacheSubnetGroup(Map<String, String> params) {
    String name = params.get("CacheSubnetGroupName");
    Map<String, Object> sg = new LinkedHashMap<>();
    sg.put("CacheSubnetGroupName", name);
    sg.put("CacheSubnetGroupDescription", params.getOrDefault("CacheSubnetGroupDescription", ""));
    sg.put("VpcId", "vpc-00000000");
    sg.put("Subnets", List.of());
    subnetGroups.put(name, sg);
    return sg;
  }

  public void deleteCacheSubnetGroup(String name) {
    subnetGroups.remove(name);
  }

  public List<Map<String, Object>> describeCacheSubnetGroups(String name) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (name != null) {
      Map<String, Object> sg = subnetGroups.get(name);
      if (sg != null) list.add(sg);
    } else {
      list.addAll(subnetGroups.values());
    }
    return list;
  }
}
