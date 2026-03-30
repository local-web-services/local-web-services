package io.localwebservices.lws.cli;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

/** Static CLI methods for calling management HTTP endpoints. */
public class LwsCli {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private static String baseUrl(int port) {
    return "http://127.0.0.1:" + port;
  }

  @SuppressWarnings("unchecked")
  public static Map<String, Object> post(int port, String path, Object body) throws IOException {
    URL url = new URL(baseUrl(port) + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    conn.setRequestProperty("Content-Length", String.valueOf(bytes.length));
    try (OutputStream os = conn.getOutputStream()) {
      os.write(bytes);
    }
    try (InputStream is = conn.getInputStream()) {
      return MAPPER.readValue(is, Map.class);
    }
  }

  @SuppressWarnings("unchecked")
  public static Map<String, Object> get(int port, String path) throws IOException {
    URL url = new URL(baseUrl(port) + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    try (InputStream is = conn.getInputStream()) {
      return MAPPER.readValue(is, Map.class);
    }
  }

  @SuppressWarnings("unchecked")
  public static Map<String, Object> put(int port, String path, Object body) throws IOException {
    URL url = new URL(baseUrl(port) + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("PUT");
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    conn.setRequestProperty("Content-Length", String.valueOf(bytes.length));
    try (OutputStream os = conn.getOutputStream()) {
      os.write(bytes);
    }
    try (InputStream is = conn.getInputStream()) {
      return MAPPER.readValue(is, Map.class);
    }
  }

  @SuppressWarnings("unchecked")
  public static Map<String, Object> delete(int port, String path) throws IOException {
    URL url = new URL(baseUrl(port) + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("DELETE");
    try (InputStream is = conn.getInputStream()) {
      return MAPPER.readValue(is, Map.class);
    }
  }

  public static void chaosEnable(int port, String service) throws IOException {
    post(port, "/_ldk/chaos", Map.of(service, Map.of("enabled", true)));
  }

  public static void chaosDisable(int port, String service) throws IOException {
    post(port, "/_ldk/chaos", Map.of(service, Map.of("enabled", false)));
  }

  public static void chaosSet(
      int port, String service, double errorRate, int latencyMin, int latencyMax)
      throws IOException {
    var config = new java.util.LinkedHashMap<String, Object>();
    config.put("enabled", true);
    if (errorRate > 0) config.put("error_rate", errorRate);
    if (latencyMin > 0) config.put("latency_min_ms", latencyMin);
    if (latencyMax > 0) config.put("latency_max_ms", latencyMax);
    post(port, "/_ldk/chaos", Map.of(service, config));
  }

  public static Map<String, Object> chaosStatus(int port) throws IOException {
    return get(port, "/_ldk/chaos");
  }

  public static Map<String, Object> iamStatus(int port) throws IOException {
    return get(port, "/_ldk/iam-auth");
  }

  public static void iamSet(int port, String mode) throws IOException {
    post(port, "/_ldk/iam-auth", Map.of("mode", mode));
  }

  public static void iamSetIdentity(int port, String identity) throws IOException {
    post(port, "/_ldk/iam-auth", Map.of("default_identity", identity));
  }

  public static void iamSetModeAndIdentity(int port, String mode, String identity)
      throws IOException {
    post(port, "/_ldk/iam-auth", Map.of("mode", mode, "default_identity", identity));
  }

  public static void iamRegisterIdentities(int port, Map<String, Object> identities)
      throws IOException {
    post(port, "/_ldk/iam-auth", Map.of("identities", identities));
  }

  public static void reset(int port) throws IOException {
    post(port, "/_ldk/reset", Map.of());
  }

  public static void lifecycleSet(int port, String service, int createDwellMs, int deleteDwellMs)
      throws IOException {
    var config = new java.util.LinkedHashMap<String, Object>();
    config.put("enabled", true);
    if (createDwellMs > 0) config.put("create_dwell_ms", createDwellMs);
    if (deleteDwellMs > 0) config.put("delete_dwell_ms", deleteDwellMs);
    post(port, "/_ldk/lifecycle", Map.of(service, config));
  }

  public static void lifecycleDisable(int port, String service) throws IOException {
    post(
        port,
        "/_ldk/lifecycle",
        Map.of(service, Map.of("enabled", false, "create_dwell_ms", 0, "delete_dwell_ms", 0)));
  }

  /** Exhausts capacity for a service (slots=0). */
  public static void capacityExhaust(int port, String service) throws IOException {
    post(port, "/_ldk/capacity", Map.of(service, Map.of("slots", 0)));
  }

  /** Resets capacity for a service to unlimited (slots=null). */
  public static void capacityUnlimited(int port, String service) throws IOException {
    java.util.Map<String, Object> slotMap = new java.util.LinkedHashMap<>();
    slotMap.put("slots", null);
    post(port, "/_ldk/capacity", Map.of(service, slotMap));
  }

  /** Returns the current capacity status from the management API. */
  public static Map<String, Object> capacityStatus(int port) throws IOException {
    return get(port, "/_ldk/capacity");
  }

  /** Sets chaos for a specific service via PUT /_ldk/chaos/{service}. */
  public static void setChaos(int port, String service, double errorRate, int latencyMs)
      throws IOException {
    var config = new java.util.LinkedHashMap<String, Object>();
    config.put("error_rate", errorRate);
    config.put("latency_ms", latencyMs);
    put(port, "/_ldk/chaos/" + service, config);
  }

  /** Resets chaos for a specific service via DELETE /_ldk/chaos/{service}. */
  public static void resetChaos(int port, String service) throws IOException {
    delete(port, "/_ldk/chaos/" + service);
  }

  /** Returns chaos status for a specific service via GET /_ldk/chaos/{service}. */
  public static Map<String, Object> getChaosStatus(int port, String service) throws IOException {
    return get(port, "/_ldk/chaos/" + service);
  }

  /** Injects state for a resource via PUT /_ldk/state/{service}/{resourceType}/{resourceId}. */
  public static void injectState(
      int port, String service, String resourceType, String resourceId, String stateValue)
      throws IOException {
    put(
        port,
        "/_ldk/state/" + service + "/" + resourceType + "/" + resourceId,
        Map.of("state", stateValue));
  }

  /** Clears injected state via DELETE /_ldk/state/{service}/{resourceType}/{resourceId}. */
  public static void clearInjectedState(
      int port, String service, String resourceType, String resourceId) throws IOException {
    delete(port, "/_ldk/state/" + service + "/" + resourceType + "/" + resourceId);
  }

  /** Registers a fake server via POST /_ldk/fake. */
  public static void registerFakeServer(int port, String name, String endpoint) throws IOException {
    post(port, "/_ldk/fake", Map.of("name", name, "endpoint", endpoint));
  }

  /** Lists all fake servers via GET /_ldk/fake. */
  public static Map<String, Object> listFakeServers(int port) throws IOException {
    return get(port, "/_ldk/fake");
  }
}
