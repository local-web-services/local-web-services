package io.localwebservices.lws.providers.docdb;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory DocDB storage. */
public class DocDbStore {

  private final Map<String, Map<String, Object>> clusters = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> instances = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> snapshots = new ConcurrentHashMap<>();

  public void reset() {
    clusters.clear();
    instances.clear();
    snapshots.clear();
  }

  public Map<String, Object> createCluster(Map<String, String> params) {
    String id = params.get("DBClusterIdentifier");
    Map<String, Object> cluster = new LinkedHashMap<>();
    cluster.put("DBClusterIdentifier", id);
    cluster.put("Status", "available");
    cluster.put("Engine", params.getOrDefault("Engine", "docdb"));
    cluster.put("Endpoint", "localhost");
    cluster.put("ReaderEndpoint", "localhost");
    cluster.put("Port", 27017);
    cluster.put("MasterUsername", params.getOrDefault("MasterUsername", "admin"));
    clusters.put(id, cluster);
    return cluster;
  }

  public Map<String, Object> deleteCluster(String id) {
    return clusters.remove(id);
  }

  public List<Map<String, Object>> describeClusters(String id) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (id != null) {
      Map<String, Object> cluster = clusters.get(id);
      if (cluster != null) list.add(cluster);
    } else {
      list.addAll(clusters.values());
    }
    return list;
  }

  public Map<String, Object> createInstance(Map<String, String> params) {
    String id = params.get("DBInstanceIdentifier");
    Map<String, Object> inst = new LinkedHashMap<>();
    inst.put("DBInstanceIdentifier", id);
    inst.put("DBClusterIdentifier", params.getOrDefault("DBClusterIdentifier", ""));
    inst.put("DBInstanceClass", params.getOrDefault("DBInstanceClass", "db.r5.large"));
    inst.put("Engine", params.getOrDefault("Engine", "docdb"));
    inst.put("DBInstanceStatus", "available");
    inst.put("Endpoint", Map.of("Address", "localhost", "Port", 27017));
    instances.put(id, inst);
    return inst;
  }

  public Map<String, Object> deleteInstance(String id) {
    return instances.remove(id);
  }

  public List<Map<String, Object>> describeInstances(String id) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (id != null) {
      Map<String, Object> inst = instances.get(id);
      if (inst != null) list.add(inst);
    } else {
      list.addAll(instances.values());
    }
    return list;
  }

  public Map<String, Object> createSnapshot(Map<String, String> params) {
    String snapshotId = params.get("DBClusterSnapshotIdentifier");
    String clusterId = params.get("DBClusterIdentifier");
    Map<String, Object> snap = new LinkedHashMap<>();
    snap.put("DBClusterSnapshotIdentifier", snapshotId);
    snap.put("DBClusterIdentifier", clusterId);
    snap.put("Status", "available");
    snap.put("Engine", "docdb");
    snapshots.put(snapshotId, snap);
    return snap;
  }

  public Map<String, Object> deleteSnapshot(String snapshotId) {
    return snapshots.remove(snapshotId);
  }

  public List<Map<String, Object>> describeSnapshots(String snapshotId) {
    List<Map<String, Object>> list = new ArrayList<>();
    if (snapshotId != null) {
      Map<String, Object> snap = snapshots.get(snapshotId);
      if (snap != null) list.add(snap);
    } else {
      list.addAll(snapshots.values());
    }
    return list;
  }
}
