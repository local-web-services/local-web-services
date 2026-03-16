package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.WebSocket;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Records log entries streamed from the ldk WebSocket endpoint.
 *
 * <p>Obtain one via {@link LwsSession#startLogCapture()} and call {@link #stop()} when done:
 * <pre>{@code
 * LogCapture logs = session.startLogCapture();
 * // run test actions
 * logs.stop();
 * logs.assertCalled("stepfunctions", "StartExecution");
 * logs.assertNoErrors();
 * }</pre>
 */
public class LogCapture implements AutoCloseable {

    /** A single request log entry. */
    public static class LogEntry {
        public final String service;
        public final String operation;
        public final String level;
        public final int statusCode;
        public final double durationMs;
        public final String timestamp;

        LogEntry(String service, String operation, String level, int statusCode,
                 double durationMs, String timestamp) {
            this.service = service;
            this.operation = operation;
            this.level = level;
            this.statusCode = statusCode;
            this.durationMs = durationMs;
            this.timestamp = timestamp;
        }
    }

    private final WebSocket webSocket;
    private final List<LogEntry> entries = new CopyOnWriteArrayList<>();
    /** Base port used for HTTP-polling fallback (non-zero means HTTP mode). */
    private final int httpBasePort;

    private LogCapture(WebSocket webSocket) {
        this.webSocket = webSocket;
        this.httpBasePort = 0;
    }

    private LogCapture(int httpBasePort) {
        this.webSocket = null;
        this.httpBasePort = httpBasePort;
    }

    /**
     * Starts a log capture that polls the {@code /_ldk/logs} HTTP endpoint.
     * Used when the WebSocket endpoint is unavailable (e.g., in-process server).
     */
    static LogCapture startHttp(LwsSession session) {
        return new LogCapture(session.getBasePort());
    }

    static LogCapture start(LwsSession session) throws Exception {
        URI uri = URI.create("ws://127.0.0.1:" + session.getBasePort() + "/_ldk/ws/logs");
        CompletableFuture<LogCapture> ready = new CompletableFuture<>();

        LogCapture[] captureHolder = new LogCapture[1];
        WebSocket ws = HttpClient.newHttpClient()
                .newWebSocketBuilder()
                .buildAsync(uri, new WebSocket.Listener() {
                    private final StringBuilder buffer = new StringBuilder();

                    @Override
                    public void onOpen(WebSocket webSocket) {
                        captureHolder[0] = new LogCapture(webSocket);
                        ready.complete(captureHolder[0]);
                        webSocket.request(1);
                    }

                    @Override
                    public CompletionStage<?> onText(WebSocket webSocket, CharSequence data, boolean last) {
                        buffer.append(data);
                        if (last) {
                            String text = buffer.toString();
                            buffer.setLength(0);
                            if (captureHolder[0] != null) {
                                captureHolder[0].addEntry(text);
                            }
                        }
                        webSocket.request(1);
                        return null;
                    }

                    @Override
                    public CompletionStage<?> onClose(WebSocket webSocket, int statusCode, String reason) {
                        return null;
                    }
                }).get();

        return ready.get();
    }

    private void addEntry(String json) {
        try {
            String service = extractJsonString(json, "service");
            String operation = extractJsonString(json, "handler");
            String level = extractJsonString(json, "level");
            int statusCode = extractJsonInt(json, "status_code");
            double durationMs = extractJsonDouble(json, "duration_ms");
            String timestamp = extractJsonString(json, "timestamp");
            entries.add(new LogEntry(service, operation, level, statusCode, durationMs, timestamp));
        } catch (Exception ignored) {
        }
    }

    /** Closes the WebSocket connection (no-op in HTTP polling mode). */
    public void stop() {
        if (webSocket != null) {
            webSocket.sendClose(WebSocket.NORMAL_CLOSURE, "done");
        }
    }

    @Override
    public void close() {
        stop();
    }

    /** Returns a snapshot of all captured log entries (polls HTTP endpoint if in HTTP mode). */
    public List<LogEntry> getEntries() {
        if (httpBasePort != 0) {
            pollHttp();
        }
        return new ArrayList<>(entries);
    }

    /**
     * Polls for up to 5 seconds for a matching entry, then throws {@link AssertionError}
     * if none was recorded. Polling handles asynchronous WebSocket delivery.
     */
    public void assertCalled(String service, String operation) {
        Instant deadline = Instant.now().plusSeconds(5);
        while (Instant.now().isBefore(deadline)) {
            if (httpBasePort != 0) pollHttp();
            for (LogEntry e : entries) {
                if (service.equals(e.service) && operation.equals(e.operation)) {
                    return;
                }
            }
            try { Thread.sleep(100); } catch (InterruptedException e) { Thread.currentThread().interrupt(); break; }
        }
        if (httpBasePort != 0) pollHttp();
        for (LogEntry e : entries) {
            if (service.equals(e.service) && operation.equals(e.operation)) return;
        }
        throw new AssertionError("Expected call to " + service + "/" + operation + " but none was recorded");
    }

    /** Throws {@link AssertionError} if any entry matches the given service and operation. */
    public void assertNotCalled(String service, String operation) {
        if (httpBasePort != 0) pollHttp();
        for (LogEntry e : entries) {
            if (service.equals(e.service) && operation.equals(e.operation)) {
                throw new AssertionError("Expected no call to " + service + "/" + operation + " but one was recorded");
            }
        }
    }

    /** Throws {@link AssertionError} if the number of matching entries differs from {@code expected}. */
    public void assertCallCount(String service, String operation, int expected) {
        Instant deadline = Instant.now().plusSeconds(5);
        while (Instant.now().isBefore(deadline)) {
            if (httpBasePort != 0) pollHttp();
            long count = entries.stream()
                    .filter(e -> service.equals(e.service) && operation.equals(e.operation))
                    .count();
            if (count == expected) return;
            try { Thread.sleep(100); } catch (InterruptedException ex) { Thread.currentThread().interrupt(); break; }
        }
        if (httpBasePort != 0) pollHttp();
        long count = entries.stream()
                .filter(e -> service.equals(e.service) && operation.equals(e.operation))
                .count();
        if (count != expected) {
            throw new AssertionError("Expected " + expected + " call(s) to " + service + "/" + operation
                    + " but got " + count);
        }
    }

    /** Throws {@link AssertionError} if any entry has a 5xx status code. */
    public void assertNoErrors() {
        if (httpBasePort != 0) pollHttp();
        for (LogEntry e : entries) {
            if (e.statusCode >= 500) {
                throw new AssertionError("Unexpected error entry: service=" + e.service
                        + " operation=" + e.operation + " status=" + e.statusCode);
            }
        }
    }

    /**
     * Polls the HTTP {@code /_ldk/logs} endpoint and replaces the local entry list.
     * Only used in HTTP polling mode (when {@code httpBasePort} is non-zero).
     */
    private void pollHttp() {
        try {
            URI uri = URI.create("http://127.0.0.1:" + httpBasePort + "/_ldk/logs");
            HttpRequest request = HttpRequest.newBuilder(uri)
                    .GET()
                    .timeout(Duration.ofSeconds(5))
                    .build();
            HttpResponse<String> response = HttpClient.newBuilder()
                    .version(HttpClient.Version.HTTP_1_1)
                    .build()
                    .send(request, HttpResponse.BodyHandlers.ofString());
            String body = response.body();
            parseHttpLogs(body);
        } catch (Exception ignored) {
        }
    }

    /**
     * Parses a JSON response of the form {@code {"logs":[{...},{...}]}} and
     * replaces {@link #entries} with the parsed log entries.
     */
    private void parseHttpLogs(String json) {
        int logsStart = json.indexOf("\"logs\"");
        if (logsStart < 0) return;
        int arrStart = json.indexOf('[', logsStart);
        int arrEnd = json.lastIndexOf(']');
        if (arrStart < 0 || arrEnd < arrStart) return;
        String arr = json.substring(arrStart + 1, arrEnd).trim();
        if (arr.isEmpty()) {
            entries.clear();
            return;
        }
        List<LogEntry> parsed = new ArrayList<>();
        List<String> objects = splitJsonObjects(arr);
        for (String obj : objects) {
            String service = extractJsonString(obj, "service");
            String operation = extractJsonString(obj, "handler");
            if (operation.isEmpty()) operation = extractJsonString(obj, "operation");
            String level = extractJsonString(obj, "level");
            int statusCode = extractJsonInt(obj, "status_code");
            double durationMs = extractJsonDouble(obj, "duration_ms");
            String timestamp = extractJsonString(obj, "timestamp");
            parsed.add(new LogEntry(service, operation, level, statusCode, durationMs, timestamp));
        }
        entries.clear();
        entries.addAll(parsed);
    }

    private static List<String> splitJsonObjects(String arr) {
        List<String> result = new ArrayList<>();
        int depth = 0;
        int start = -1;
        for (int i = 0; i < arr.length(); i++) {
            char c = arr.charAt(i);
            if (c == '{') {
                if (depth == 0) start = i;
                depth++;
            } else if (c == '}') {
                depth--;
                if (depth == 0 && start >= 0) {
                    result.add(arr.substring(start, i + 1));
                    start = -1;
                }
            }
        }
        return result;
    }

    /** Returns all captured entries whose {@code service} field matches the given value. */
    public List<LogEntry> forService(String service) {
        if (httpBasePort != 0) pollHttp();
        return entries.stream()
                .filter(e -> service.equals(e.service))
                .collect(java.util.stream.Collectors.toList());
    }

    /** Returns all captured entries whose {@code operation} field matches the given value. */
    public List<LogEntry> forOperation(String operation) {
        if (httpBasePort != 0) pollHttp();
        return entries.stream()
                .filter(e -> operation.equals(e.operation))
                .collect(java.util.stream.Collectors.toList());
    }

    // Minimal JSON field extractors — avoids adding a JSON library dependency.

    private static String extractJsonString(String json, String key) {
        String pattern = "\"" + key + "\":\"";
        int start = json.indexOf(pattern);
        if (start < 0) return "";
        start += pattern.length();
        int end = json.indexOf('"', start);
        return end < 0 ? "" : json.substring(start, end);
    }

    private static int extractJsonInt(String json, String key) {
        String pattern = "\"" + key + "\":";
        int start = json.indexOf(pattern);
        if (start < 0) return 0;
        start += pattern.length();
        int end = start;
        while (end < json.length() && (Character.isDigit(json.charAt(end)) || json.charAt(end) == '-')) {
            end++;
        }
        try {
            return Integer.parseInt(json.substring(start, end));
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private static double extractJsonDouble(String json, String key) {
        String pattern = "\"" + key + "\":";
        int start = json.indexOf(pattern);
        if (start < 0) return 0;
        start += pattern.length();
        int end = start;
        while (end < json.length() && (Character.isDigit(json.charAt(end))
                || json.charAt(end) == '.' || json.charAt(end) == '-')) {
            end++;
        }
        try {
            return Double.parseDouble(json.substring(start, end));
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
