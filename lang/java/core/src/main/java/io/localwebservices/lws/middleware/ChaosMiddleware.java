package io.localwebservices.lws.middleware;

import com.sun.net.httpserver.HttpExchange;
import io.localwebservices.lws.ServerState;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Random;

/** Chaos injection middleware. */
public class ChaosMiddleware {

    private static final Random RANDOM = new Random();

    /**
     * Apply chaos rules.
     * @return true if chaos was applied and the request should not be processed further.
     */
    public static boolean applyChaos(ServerState state, String service, String operation,
                                      HttpExchange exchange, boolean xmlProtocol) throws IOException, InterruptedException {
        Map<String, Map<String, Object>> serviceRules = state.chaosRules.get(service);
        if (serviceRules == null) return false;

        Map<String, Object> rule = serviceRules.get(operation);
        if (rule == null) rule = serviceRules.get("*");
        if (rule == null) return false;

        Number errorRate = (Number) rule.get("error_rate");
        Number latencyMin = (Number) rule.get("latency_min_ms");
        Number latencyMax = (Number) rule.get("latency_max_ms");
        Number latencyMs = (Number) rule.get("latency_ms");

        long latencyMinVal = latencyMin != null ? latencyMin.longValue() : (latencyMs != null ? latencyMs.longValue() : 0);
        long latencyMaxVal = latencyMax != null ? latencyMax.longValue() : latencyMinVal;

        // Latency-only mode: apply delay and let through
        if ((errorRate == null || errorRate.doubleValue() <= 0) && latencyMinVal > 0) {
            long delay = latencyMinVal;
            if (latencyMaxVal > latencyMinVal) {
                delay = latencyMinVal + (long) (RANDOM.nextDouble() * (latencyMaxVal - latencyMinVal));
            }
            Thread.sleep(delay);
            return false;
        }

        // Error rate check
        if (errorRate == null || errorRate.doubleValue() <= 0) return false;
        if (RANDOM.nextDouble() > errorRate.doubleValue()) return false;

        // Apply latency before error
        if (latencyMinVal > 0) {
            long delay = latencyMinVal;
            if (latencyMaxVal > latencyMinVal) {
                delay = latencyMinVal + (long) (RANDOM.nextDouble() * (latencyMaxVal - latencyMinVal));
            }
            Thread.sleep(delay);
        }

        String errorCode = rule.containsKey("error_code") ? (String) rule.get("error_code") : "InternalError";
        String errorMessage = rule.containsKey("error_message") ? (String) rule.get("error_message") : "Chaos error: " + errorCode;

        if (xmlProtocol) {
            String xml = "<?xml version=\"1.0\"?><ErrorResponse><Error><Code>ServiceUnavailable</Code><Message>chaos</Message></Error></ErrorResponse>";
            sendResponse(exchange, 500, "text/xml", xml);
        } else {
            String json = "{\"__type\":\"" + errorCode + "\",\"message\":\"" + errorMessage + "\"}";
            sendResponse(exchange, 500, "application/x-amz-json-1.0", json);
        }
        return true;
    }

    public static void sendResponse(HttpExchange exchange, int status, String contentType, String body) throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", contentType);
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }
}
