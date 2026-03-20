package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Configures resource lifecycle simulation for a single AWS service via the {@code /_ldk/lifecycle}
 * management API.
 *
 * <p>Obtain a builder via {@link LwsSession#lifecycle(String)}:
 *
 * <pre>{@code
 * session.lifecycle("dynamodb").createDwellMs(500).deleteDwellMs(200).apply();
 * }</pre>
 */
public class LifecycleBuilder {

  private final LwsSession session;
  private final String service;
  private final Map<String, Object> config = new LinkedHashMap<>();

  LifecycleBuilder(LwsSession session, String service) {
    this.session = session;
    this.service = service;
    config.put("enabled", true);
  }

  /** Sets the time resources spend in CREATING state before becoming ACTIVE. */
  public LifecycleBuilder createDwellMs(int ms) {
    config.put("create_dwell_ms", ms);
    return this;
  }

  /** Sets the time resources spend in DELETING state before removal. */
  public LifecycleBuilder deleteDwellMs(int ms) {
    config.put("delete_dwell_ms", ms);
    return this;
  }

  /** POSTs the lifecycle configuration to the management API. */
  public void apply() throws Exception {
    String configJson = buildConfigJson();
    post("{\"" + escape(service) + "\":" + configJson + "}");
  }

  /** Disables lifecycle simulation for this service. */
  public void clear() throws Exception {
    String disabledJson = "{\"enabled\":false,\"create_dwell_ms\":0,\"delete_dwell_ms\":0}";
    post("{\"" + escape(service) + "\":" + disabledJson + "}");
  }

  private String buildConfigJson() {
    StringBuilder sb = new StringBuilder("{");
    boolean first = true;
    for (Map.Entry<String, Object> entry : config.entrySet()) {
      if (!first) sb.append(",");
      sb.append("\"").append(escape(entry.getKey())).append("\":");
      Object value = entry.getValue();
      if (value instanceof Boolean) {
        sb.append(value);
      } else if (value instanceof Integer) {
        sb.append(value);
      } else {
        sb.append("\"").append(escape(value.toString())).append("\"");
      }
      first = false;
    }
    sb.append("}");
    return sb.toString();
  }

  private void post(String json) throws Exception {
    URI uri = URI.create("http://127.0.0.1:" + session.getBasePort() + "/_ldk/lifecycle");
    HttpRequest request =
        HttpRequest.newBuilder(uri)
            .POST(HttpRequest.BodyPublishers.ofString(json))
            .header("Content-Type", "application/json")
            .timeout(Duration.ofSeconds(10))
            .build();
    HttpClient.newBuilder()
        .version(HttpClient.Version.HTTP_1_1)
        .build()
        .send(request, HttpResponse.BodyHandlers.discarding());
  }

  private static String escape(String s) {
    return s.replace("\\", "\\\\").replace("\"", "\\\"");
  }
}
