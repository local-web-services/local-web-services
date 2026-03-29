package io.localwebservices.lws.providers.secretsmanager;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory SecretsManager storage. */
public class SecretsManagerStore {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final Map<String, Map<String, Object>> secrets = new ConcurrentHashMap<>();
  private final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public void reset() {
    secrets.clear();
    resourceTags.clear();
  }

  public String secretArn(String name) {
    return "arn:aws:secretsmanager:" + REGION + ":" + ACCOUNT + ":secret:" + name;
  }

  public boolean secretExists(String name) {
    Map<String, Object> s = secrets.get(name);
    return s != null && s.get("DeletedDate") == null;
  }

  public Map<String, Object> createSecret(
      String name, Object secretString, Object secretBinary, Object tags) {
    String arn = secretArn(name);
    Map<String, Object> secret = new LinkedHashMap<>();
    secret.put("Name", name);
    secret.put("ARN", arn);
    secret.put("SecretString", secretString);
    secret.put("SecretBinary", secretBinary);
    secret.put("VersionId", UUID.randomUUID().toString());
    secret.put("CreatedDate", System.currentTimeMillis() / 1000.0);
    secret.put("DeletedDate", null);
    secret.put("Tags", tags != null ? tags : List.of());
    secrets.put(name, secret);
    return secret;
  }

  public Map<String, Object> findSecret(String secretId) {
    if (secrets.containsKey(secretId)) return secrets.get(secretId);
    for (Map<String, Object> secret : secrets.values()) {
      if (secretId.equals(secret.get("ARN"))) return secret;
    }
    return null;
  }

  public void putSecretValue(Map<String, Object> secret, Object secretString, Object secretBinary) {
    secret.put("SecretString", secretString);
    secret.put("SecretBinary", secretBinary);
    secret.put("VersionId", UUID.randomUUID().toString());
  }

  public void updateSecret(
      Map<String, Object> secret,
      Object secretString,
      Object secretBinary,
      String versionId,
      String description) {
    secret.put("SecretString", secretString);
    secret.put("SecretBinary", secretBinary);
    secret.put("VersionId", versionId);
    if (description != null && !description.isEmpty()) {
      secret.put("Description", description);
    }
  }

  public void deleteSecret(String name, boolean force) {
    if (force) {
      secrets.remove(name);
    } else {
      Map<String, Object> secret = secrets.get(name);
      if (secret != null) secret.put("DeletedDate", System.currentTimeMillis() / 1000.0);
    }
  }

  public void restoreSecret(Map<String, Object> secret) {
    secret.remove("DeletedDate");
  }

  public List<Map<String, Object>> listSecrets() {
    List<Map<String, Object>> list = new ArrayList<>();
    for (Map<String, Object> secret : secrets.values()) {
      Map<String, Object> entry = new LinkedHashMap<>();
      entry.put("Name", secret.get("Name"));
      entry.put("ARN", secret.get("ARN"));
      entry.put("CreatedDate", secret.get("CreatedDate"));
      if (secret.get("DeletedDate") != null) entry.put("DeletedDate", secret.get("DeletedDate"));
      list.add(entry);
    }
    return list;
  }

  @SuppressWarnings("unchecked")
  public void tagResource(String secretId, List<Map<String, Object>> newTags) {
    List<Map<String, String>> existing =
        resourceTags.computeIfAbsent(secretId, k -> new ArrayList<>());
    for (Map<String, Object> tag : newTags) {
      existing.add(Map.of("Key", (String) tag.get("Key"), "Value", (String) tag.get("Value")));
    }
  }

  public void untagResource(String secretId, List<String> tagKeys) {
    List<Map<String, String>> existing = resourceTags.getOrDefault(secretId, new ArrayList<>());
    existing.removeIf(t -> tagKeys.contains(t.get("Key")));
  }

  public List<Map<String, String>> listTags(String secretId) {
    return resourceTags.getOrDefault(secretId, List.of());
  }
}
