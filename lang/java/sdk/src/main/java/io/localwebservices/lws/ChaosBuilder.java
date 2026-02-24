package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Configures chaos engineering settings for a single AWS service via the
 * {@code /_ldk/chaos} management API.
 *
 * <p>Obtain a builder via {@link LwsSession#chaos(String)}:
 * <pre>{@code
 * session.chaos("stepfunctions").errorRate(0.5).apply();
 * // run test that should handle errors
 * session.chaos("stepfunctions").clear();
 * }</pre>
 */
public class ChaosBuilder {

    private final LwsSession session;
    private final String service;
    private double errorRate;
    private int latencyMinMs;
    private int latencyMaxMs;
    private double connectionResetRate;
    private double timeoutRate;

    ChaosBuilder(LwsSession session, String service) {
        this.session = session;
        this.service = service;
    }

    /** Sets the probability (0.0–1.0) that requests return an error. */
    public ChaosBuilder errorRate(double rate) {
        this.errorRate = rate;
        return this;
    }

    /** Configures artificial latency range applied to requests. */
    public ChaosBuilder latency(int minMs, int maxMs) {
        this.latencyMinMs = minMs;
        this.latencyMaxMs = maxMs;
        return this;
    }

    /** Sets the probability (0.0–1.0) that connections are reset. */
    public ChaosBuilder connectionResetRate(double rate) {
        this.connectionResetRate = rate;
        return this;
    }

    /** Sets the probability (0.0–1.0) that requests time out. */
    public ChaosBuilder timeoutRate(double rate) {
        this.timeoutRate = rate;
        return this;
    }

    /** Sends the chaos configuration to the management API with {@code enabled:true}. */
    public void apply() throws Exception {
        post(true);
    }

    /** Disables chaos for this service and resets all rates to zero. */
    public void clear() throws Exception {
        errorRate = 0;
        latencyMinMs = 0;
        latencyMaxMs = 0;
        connectionResetRate = 0;
        timeoutRate = 0;
        post(false);
    }

    private void post(boolean enabled) throws Exception {
        StringBuilder cfg = new StringBuilder("{\"enabled\":").append(enabled);
        if (errorRate != 0) cfg.append(",\"error_rate\":").append(errorRate);
        if (latencyMinMs != 0) cfg.append(",\"latency_min_ms\":").append(latencyMinMs);
        if (latencyMaxMs != 0) cfg.append(",\"latency_max_ms\":").append(latencyMaxMs);
        if (connectionResetRate != 0) cfg.append(",\"connection_reset_rate\":").append(connectionResetRate);
        if (timeoutRate != 0) cfg.append(",\"timeout_rate\":").append(timeoutRate);
        cfg.append("}");

        String body = "{\"" + service + "\":" + cfg + "}";
        URI uri = URI.create("http://127.0.0.1:" + session.getBasePort() + "/_ldk/chaos");
        HttpRequest request = HttpRequest.newBuilder(uri)
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .header("Content-Type", "application/json")
                .timeout(Duration.ofSeconds(10))
                .build();
        HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build()
                .send(request, HttpResponse.BodyHandlers.discarding());
    }
}
