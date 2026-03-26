package io.localwebservices.lws.providers.glacier;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory Glacier storage. */
public class GlacierStore {

  private final Map<String, Map<String, Object>> vaults = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Map<String, Object>>> archives = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Map<String, Object>>> jobs = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Map<String, Object>>> multipartUploads =
      new ConcurrentHashMap<>();

  public void reset() {
    vaults.clear();
    archives.clear();
    jobs.clear();
    multipartUploads.clear();
  }

  public Map<String, Object> createVault(String vaultName) {
    Map<String, Object> vault = new LinkedHashMap<>();
    vault.put("VaultName", vaultName);
    vault.put("VaultARN", "arn:aws:glacier:us-east-1:000000000000:vaults/" + vaultName);
    vault.put("CreationDate", new java.util.Date().toString());
    vault.put("NumberOfArchives", 0);
    vault.put("SizeInBytes", 0);
    vaults.put(vaultName, vault);
    return vault;
  }

  public void deleteVault(String vaultName) {
    vaults.remove(vaultName);
  }

  public Map<String, Object> getVault(String vaultName) {
    return vaults.get(vaultName);
  }

  public List<Map<String, Object>> listVaults() {
    return new ArrayList<>(vaults.values());
  }

  public String uploadArchive(String vaultName, String description, int size) {
    String archiveId = UUID.randomUUID().toString();
    Map<String, Object> archive = new LinkedHashMap<>();
    archive.put("ArchiveId", archiveId);
    archive.put("VaultName", vaultName);
    archive.put("ArchiveDescription", description);
    archive.put("Size", size);
    archive.put("CreationDate", new java.util.Date().toString());
    archives.computeIfAbsent(vaultName, k -> new ConcurrentHashMap<>()).put(archiveId, archive);
    return archiveId;
  }

  public void deleteArchive(String vaultName, String archiveId) {
    Map<String, Map<String, Object>> vaultArchives =
        archives.getOrDefault(vaultName, new ConcurrentHashMap<>());
    vaultArchives.remove(archiveId);
  }

  public List<Map<String, Object>> listArchives(String vaultName) {
    return new ArrayList<>(archives.getOrDefault(vaultName, new ConcurrentHashMap<>()).values());
  }

  public String initiateJob(String vaultName, Map<String, Object> jobBody) {
    String jobId = UUID.randomUUID().toString();
    Map<String, Object> job = new LinkedHashMap<>();
    job.put("JobId", jobId);
    job.put("VaultName", vaultName);
    job.put("StatusCode", "Succeeded");
    job.put("Action", jobBody.getOrDefault("Type", "InventoryRetrieval"));
    jobs.computeIfAbsent(vaultName, k -> new ConcurrentHashMap<>()).put(jobId, job);
    return jobId;
  }

  public Map<String, Object> getJob(String vaultName, String jobId) {
    return jobs.getOrDefault(vaultName, new ConcurrentHashMap<>()).get(jobId);
  }

  public List<Map<String, Object>> listJobs(String vaultName) {
    return new ArrayList<>(jobs.getOrDefault(vaultName, new ConcurrentHashMap<>()).values());
  }

  public String initiateMultipartUpload(String vaultName, String partSize, String description) {
    String uploadId = UUID.randomUUID().toString();
    Map<String, Object> upload = new LinkedHashMap<>();
    upload.put("MultipartUploadId", uploadId);
    upload.put("VaultName", vaultName);
    upload.put("PartSizeInBytes", partSize);
    upload.put("ArchiveDescription", description != null ? description : "");
    upload.put("CreationDate", new java.util.Date().toString());
    multipartUploads
        .computeIfAbsent(vaultName, k -> new ConcurrentHashMap<>())
        .put(uploadId, upload);
    return uploadId;
  }

  public boolean multipartUploadExists(String vaultName, String uploadId) {
    return multipartUploads
        .getOrDefault(vaultName, new ConcurrentHashMap<>())
        .containsKey(uploadId);
  }

  public String completeMultipartUpload(String vaultName, String uploadId) {
    multipartUploads.getOrDefault(vaultName, new ConcurrentHashMap<>()).remove(uploadId);
    return uploadArchive(vaultName, "assembled-multipart", 0);
  }

  public void abortMultipartUpload(String vaultName, String uploadId) {
    multipartUploads.getOrDefault(vaultName, new ConcurrentHashMap<>()).remove(uploadId);
  }

  public List<Map<String, Object>> listMultipartUploads(String vaultName) {
    return new ArrayList<>(
        multipartUploads.getOrDefault(vaultName, new ConcurrentHashMap<>()).values());
  }
}
