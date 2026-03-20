package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Configures capacity slot settings for a single AWS service via the {@code /_ldk/capacity}
 * management API.
 *
 * <p>Obtain a builder via {@link LwsSession#capacity(String)}:
 *
 * <pre>{@code
 * session.capacity("stepfunctions").exhaust().apply();
 * // run test that should handle capacity errors
 * session.capacity("stepfunctions").unlimited().apply();
 * }</pre>
 */
public class CapacityBuilder {

  private final LwsSession session;
  private final String service;
  private Integer slots;

  CapacityBuilder(LwsSession session, String service) {
    this.session = session;
    this.service = service;
  }

  /** Sets slots to 0, exhausting capacity so all requests fail with a capacity error. */
  public CapacityBuilder exhaust() {
    this.slots = 0;
    return this;
  }

  /** Sets the number of available capacity slots. */
  public CapacityBuilder slots(int n) {
    this.slots = n;
    return this;
  }

  /** Sets slots to null (unlimited), removing any capacity restriction. */
  public CapacityBuilder unlimited() {
    this.slots = null;
    return this;
  }

  /** POSTs the capacity configuration to the management API. */
  public void apply() throws Exception {
    String slotsJson = slots == null ? "null" : String.valueOf(slots);
    String body = "{\"" + service + "\":{\"slots\":" + slotsJson + "}}";
    URI uri = URI.create("http://127.0.0.1:" + session.getBasePort() + "/_ldk/capacity");
    HttpRequest request =
        HttpRequest.newBuilder(uri)
            .POST(HttpRequest.BodyPublishers.ofString(body))
            .header("Content-Type", "application/json")
            .timeout(Duration.ofSeconds(10))
            .build();
    HttpClient.newBuilder()
        .version(HttpClient.Version.HTTP_1_1)
        .build()
        .send(request, HttpResponse.BodyHandlers.discarding());
  }

  /** Resets capacity to unlimited and applies the change. */
  public void clear() throws Exception {
    unlimited();
    apply();
  }
}
