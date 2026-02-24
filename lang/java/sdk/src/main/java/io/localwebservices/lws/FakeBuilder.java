package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Configures fake responses for a single AWS service via the {@code /_ldk/aws-mock} API.
 *
 * <p>Obtain a builder via {@link LwsSession#fake(String)}:
 * <pre>{@code
 * FakeBuilder sfnFake = session.fake("stepfunctions")
 *         .operation("start-execution").respond(200, Map.of("executionArn", "..."))
 *         .operation("describe-execution").respond(200, Map.of("status", "SUCCEEDED", ...));
 * // later...
 * sfnFake.clear();
 * }</pre>
 */
public class FakeBuilder {

    private final LwsSession session;
    private final String service;
    private final List<FakeRule> rules = new ArrayList<>();

    FakeBuilder(LwsSession session, String service) {
        this.session = session;
        this.service = service;
    }

    /**
     * Starts building a fake rule for the named operation (e.g. {@code "start-execution"}).
     * Chain {@link FakeRuleBuilder#respond} or {@link FakeRuleBuilder#error} to finish.
     */
    public FakeRuleBuilder operation(String operationName) {
        return new FakeRuleBuilder(this, operationName);
    }

    /** Removes all fake rules for this service. */
    public void clear() throws Exception {
        rules.clear();
        apply(false);
    }

    void addRule(FakeRule rule) throws Exception {
        rules.add(rule);
        apply(true);
    }

    private void apply(boolean enabled) throws Exception {
        StringBuilder rulesJson = new StringBuilder("[");
        for (int i = 0; i < rules.size(); i++) {
            if (i > 0) rulesJson.append(",");
            FakeRule r = rules.get(i);
            rulesJson.append("{\"operation\":").append(jsonString(r.operation));
            if (r.matchHeaders != null && !r.matchHeaders.isEmpty()) {
                rulesJson.append(",\"match_headers\":{");
                boolean firstHeader = true;
                for (Map.Entry<String, String> entry : r.matchHeaders.entrySet()) {
                    if (!firstHeader) rulesJson.append(",");
                    rulesJson.append(jsonString(entry.getKey())).append(":").append(jsonString(entry.getValue()));
                    firstHeader = false;
                }
                rulesJson.append("}");
            }
            rulesJson.append(",\"response\":{\"status\":").append(r.response.status)
                    .append(",\"content_type\":").append(jsonString(r.response.contentType))
                    .append(",\"body\":").append(jsonString(r.response.body));
            if (r.response.delayMs > 0) {
                rulesJson.append(",\"delay_ms\":").append(r.response.delayMs);
            }
            rulesJson.append("}}");
        }
        rulesJson.append("]");

        String body = "{\"" + service + "\":{\"enabled\":" + enabled + ",\"rules\":" + rulesJson + "}}";
        URI uri = URI.create("http://127.0.0.1:" + session.getBasePort() + "/_ldk/aws-mock");
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

    static String jsonString(String value) {
        if (value == null) return "\"\"";
        return "\"" + value.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t") + "\"";
    }

    static String toBodyString(Object body) {
        if (body == null) return "";
        if (body instanceof String s) return s;
        return toJson(body);
    }

    @SuppressWarnings("unchecked")
    static String toJson(Object value) {
        if (value == null) return "null";
        if (value instanceof String s) return jsonString(s);
        if (value instanceof Boolean b) return b.toString();
        if (value instanceof Number n) {
            double d = n.doubleValue();
            if (d == Math.floor(d) && !Double.isInfinite(d)) {
                return String.valueOf(n.longValue());
            }
            return n.toString();
        }
        if (value instanceof Map<?, ?> map) {
            StringBuilder sb = new StringBuilder("{");
            boolean first = true;
            for (Map.Entry<?, ?> entry : map.entrySet()) {
                if (!first) sb.append(",");
                sb.append(jsonString(entry.getKey().toString())).append(":").append(toJson(entry.getValue()));
                first = false;
            }
            return sb.append("}").toString();
        }
        if (value instanceof List<?> list) {
            StringBuilder sb = new StringBuilder("[");
            for (int i = 0; i < list.size(); i++) {
                if (i > 0) sb.append(",");
                sb.append(toJson(list.get(i)));
            }
            return sb.append("]").toString();
        }
        return jsonString(value.toString());
    }

    static class FakeRule {
        final String operation;
        final Map<String, String> matchHeaders;
        final FakeResponse response;

        FakeRule(String operation, Map<String, String> matchHeaders, FakeResponse response) {
            this.operation = operation;
            this.matchHeaders = matchHeaders;
            this.response = response;
        }
    }

    static class FakeResponse {
        final int status;
        final String contentType;
        final String body;
        final int delayMs;

        FakeResponse(int status, String contentType, String body, int delayMs) {
            this.status = status;
            this.contentType = contentType;
            this.body = body;
            this.delayMs = delayMs;
        }
    }

    /**
     * Builds a single fake rule for one operation.
     */
    public static class FakeRuleBuilder {

        private final FakeBuilder parent;
        private final String operation;
        private final Map<String, String> headers = new java.util.LinkedHashMap<>();
        private int delayMs;

        FakeRuleBuilder(FakeBuilder parent, String operation) {
            this.parent = parent;
            this.operation = operation;
        }

        /** Adds a required request header match to the rule. */
        public FakeRuleBuilder withHeader(String name, String value) {
            headers.put(name, value);
            return this;
        }

        /** Sets a response delay in milliseconds for the rule. */
        public FakeRuleBuilder delayMs(int ms) {
            this.delayMs = ms;
            return this;
        }

        /**
         * Configures a success response. {@code body} may be a {@link String}
         * or any JSON-serialisable object (e.g. a {@link Map}).
         *
         * @return the parent {@link FakeBuilder} so further operations can be chained
         */
        public FakeBuilder respond(int statusCode, Object body) throws Exception {
            String bodyStr = toBodyString(body);
            parent.addRule(new FakeRule(operation, headers.isEmpty() ? null : new java.util.LinkedHashMap<>(headers),
                    new FakeResponse(statusCode, "application/json", bodyStr, delayMs)));
            return parent;
        }

        /**
         * Configures the operation to return an AWS-style error response.
         *
         * @return the parent {@link FakeBuilder} so further operations can be chained
         */
        public FakeBuilder error(String errorType, String message) throws Exception {
            String bodyStr = "{\"__type\":" + jsonString(errorType) + ",\"message\":" + jsonString(message) + "}";
            return respond(400, bodyStr);
        }
    }
}
