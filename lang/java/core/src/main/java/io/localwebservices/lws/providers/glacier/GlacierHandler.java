package io.localwebservices.lws.providers.glacier;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** Glacier wire-protocol HTTP handler (REST JSON). */
public class GlacierHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final ServerState state;
  private final GlacierStore store;

  public GlacierHandler(ServerState state) {
    this.state = state;
    this.store = new GlacierStore();
    state.resetCallbacks.add(store::reset);
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String method = exchange.getRequestMethod();
    String path = exchange.getRequestURI().getPath();
    // path: /{accountId}/vaults[/{vaultName}[/archives[/{archiveId}]][/jobs[/{jobId}[/output]]]]
    String[] segments = path.split("/");
    // segments[0] = "", segments[1] = accountId, segments[2] = "vaults", segments[3] = vaultName,
    // ...

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }

    try {
      String operation = inferOperation(method, segments);
      if (IamMiddleware.applyIamAuth(state, "glacier", operation, exchange, false)) return;
      if (ChaosMiddleware.applyChaos(state, "glacier", operation, exchange, false)) return;

      route(method, segments, bodyBytes, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("code", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "code",
              "ResourceNotFoundException",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  private String inferOperation(String method, String[] segments) {
    int len = segments.length;
    if (len >= 5 && "archives".equals(segments[4])) {
      if (len >= 6) return "DELETE".equals(method) ? "DeleteArchive" : "GetArchive";
      return "POST".equals(method) ? "UploadArchive" : "ListArchives";
    }
    if (len >= 5 && "jobs".equals(segments[4])) {
      if (len >= 7 && "output".equals(segments[6])) return "GetJobOutput";
      if (len >= 6) return "GET".equals(method) ? "DescribeJob" : "InitiateJob";
      return "POST".equals(method) ? "InitiateJob" : "ListJobs";
    }
    if (len >= 4) {
      if ("PUT".equals(method)) return "CreateVault";
      if ("DELETE".equals(method)) return "DeleteVault";
      if ("GET".equals(method)) return "DescribeVault";
    }
    return "GET".equals(method) ? "ListVaults" : "Unknown";
  }

  @SuppressWarnings("unchecked")
  private void route(String method, String[] segments, byte[] bodyBytes, HttpExchange exchange)
      throws IOException {
    int len = segments.length;
    // segments: ["", accountId, "vaults", ...]
    String vaultName = len >= 4 ? segments[3] : null;

    // /archives path
    if (len >= 5 && "archives".equals(segments[4])) {
      String archiveId = len >= 6 ? segments[5] : null;
      if ("POST".equals(method) && archiveId == null) {
        // UploadArchive
        String description = exchange.getRequestHeaders().getFirst("x-amz-archive-description");
        String newArchiveId = store.uploadArchive(vaultName, description, bodyBytes.length);
        exchange.getResponseHeaders().set("x-amz-archive-id", newArchiveId);
        sendJson(exchange, 201, Map.of("archiveId", newArchiveId));
        return;
      }
      if ("DELETE".equals(method) && archiveId != null) {
        store.deleteArchive(vaultName, archiveId);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
    }

    // /jobs path
    if (len >= 5 && "jobs".equals(segments[4])) {
      String jobId = len >= 6 ? segments[5] : null;
      boolean isOutput = len >= 7 && "output".equals(segments[6]);

      if (isOutput && "GET".equals(method) && jobId != null) {
        // GetJobOutput
        byte[] outputBytes = "{}".getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(200, outputBytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
          os.write(outputBytes);
        }
        return;
      }

      if ("POST".equals(method) && jobId == null) {
        // InitiateJob
        Map<String, Object> jobBody =
            bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();
        String newJobId = store.initiateJob(vaultName, jobBody);
        exchange.getResponseHeaders().set("x-amz-job-id", newJobId);
        sendJson(exchange, 202, Map.of("jobId", newJobId));
        return;
      }

      if ("GET".equals(method) && jobId != null) {
        // DescribeJob
        Map<String, Object> job = store.getJob(vaultName, jobId);
        if (job == null) {
          sendJson(
              exchange,
              404,
              Map.of("code", "ResourceNotFoundException", "message", "Job not found: " + jobId));
          return;
        }
        sendJson(exchange, 200, job);
        return;
      }

      if ("GET".equals(method) && jobId == null) {
        // ListJobs
        List<Map<String, Object>> jobList = store.listJobs(vaultName);
        sendJson(exchange, 200, Map.of("JobList", jobList));
        return;
      }
    }

    // Vault operations: /{accountId}/vaults/{vaultName} or /{accountId}/vaults
    if (len >= 4 && vaultName != null) {
      if ("PUT".equals(method)) {
        // CreateVault
        store.createVault(vaultName);
        sendJson(exchange, 201, Map.of());
        return;
      }
      if ("DELETE".equals(method)) {
        store.deleteVault(vaultName);
        exchange.sendResponseHeaders(204, -1);
        return;
      }
      if ("GET".equals(method)) {
        Map<String, Object> vault = store.getVault(vaultName);
        if (vault == null) {
          sendJson(
              exchange,
              404,
              Map.of(
                  "code", "ResourceNotFoundException", "message", "Vault not found: " + vaultName));
          return;
        }
        sendJson(exchange, 200, vault);
        return;
      }
    }

    if ("GET".equals(method) && len <= 3) {
      // ListVaults
      List<Map<String, Object>> vaultList = store.listVaults();
      sendJson(exchange, 200, Map.of("VaultList", vaultList));
      return;
    }

    sendJson(
        exchange,
        400,
        Map.of(
            "code",
            "UnknownOperation",
            "message",
            "Unknown operation for " + method + " " + String.join("/", segments)));
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/json");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
