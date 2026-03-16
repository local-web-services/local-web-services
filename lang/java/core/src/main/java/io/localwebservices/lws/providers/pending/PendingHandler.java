package io.localwebservices.lws.providers.pending;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;

import java.io.*;
import java.nio.charset.StandardCharsets;

/**
 * A generic pending HTTP handler that applies IAM and chaos middleware.
 * Used for services not yet fully implemented - IAM/chaos still need to be enforced.
 */
public class PendingHandler implements HttpHandler {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    private final ServerState state;
    private final String serviceName;

    public PendingHandler(ServerState state, String serviceName) {
        this.state = state;
        this.serviceName = serviceName;
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        // Determine operation from X-Amz-Target header or request path
        String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
        String operation = "";
        if (target != null && target.contains(".")) {
            operation = target.substring(target.lastIndexOf('.') + 1);
        } else if (target != null) {
            operation = target;
        }

        // Consume request body
        try (InputStream is = exchange.getRequestBody()) { is.readAllBytes(); }

        try {
            if (IamMiddleware.applyIamAuth(state, serviceName, operation, exchange, false)) return;
            if (ChaosMiddleware.applyChaos(state, serviceName, operation, exchange, false)) return;

            // Return pending response
            byte[] bytes = MAPPER.writeValueAsBytes(
                java.util.Map.of("message", "pending: " + serviceName + " " + operation)
            );
            exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
            exchange.sendResponseHeaders(200, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            byte[] bytes = MAPPER.writeValueAsBytes(java.util.Map.of("message", "Interrupted"));
            exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
            exchange.sendResponseHeaders(500, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
        } catch (Exception e) {
            byte[] bytes = MAPPER.writeValueAsBytes(java.util.Map.of("message", e.getMessage() != null ? e.getMessage() : "Error"));
            exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
            exchange.sendResponseHeaders(400, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) { os.write(bytes); }
        }
    }
}
