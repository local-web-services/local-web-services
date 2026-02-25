package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.WebSocket;
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

    private LogCapture(WebSocket webSocket) {
        this.webSocket = webSocket;
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

    /** Closes the WebSocket connection. */
    public void stop() {
        webSocket.sendClose(WebSocket.NORMAL_CLOSURE, "done");
    }

    @Override
    public void close() {
        stop();
    }

    /** Returns a snapshot of all captured log entries. */
    public List<LogEntry> getEntries() {
        return new ArrayList<>(entries);
    }

    /**
     * Polls for up to 5 seconds for a matching entry, then throws {@link AssertionError}
     * if none was recorded. Polling handles asynchronous WebSocket delivery.
     */
    public void assertCalled(String service, String operation) {
        Instant deadline = Instant.now().plusSeconds(5);
        while (Instant.now().isBefore(deadline)) {
            for (LogEntry e : entries) {
                if (service.equals(e.service) && operation.equals(e.operation)) {
                    return;
                }
            }
            try { Thread.sleep(50); } catch (InterruptedException e) { Thread.currentThread().interrupt(); break; }
        }
        for (LogEntry e : entries) {
            if (service.equals(e.service) && operation.equals(e.operation)) return;
        }
        throw new AssertionError("Expected call to " + service + "/" + operation + " but none was recorded");
    }

    /** Throws {@link AssertionError} if any entry matches the given service and operation. */
    public void assertNotCalled(String service, String operation) {
        for (LogEntry e : entries) {
            if (service.equals(e.service) && operation.equals(e.operation)) {
                throw new AssertionError("Expected no call to " + service + "/" + operation + " but one was recorded");
            }
        }
    }

    /** Throws {@link AssertionError} if the number of matching entries differs from {@code expected}. */
    public void assertCallCount(String service, String operation, int expected) {
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
        for (LogEntry e : entries) {
            if (e.statusCode >= 500) {
                throw new AssertionError("Unexpected error entry: service=" + e.service
                        + " operation=" + e.operation + " status=" + e.statusCode);
            }
        }
    }

    /** Returns all captured entries whose {@code service} field matches the given value. */
    public List<LogEntry> forService(String service) {
        return entries.stream()
                .filter(e -> service.equals(e.service))
                .collect(java.util.stream.Collectors.toList());
    }

    /** Returns all captured entries whose {@code operation} field matches the given value. */
    public List<LogEntry> forOperation(String operation) {
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
