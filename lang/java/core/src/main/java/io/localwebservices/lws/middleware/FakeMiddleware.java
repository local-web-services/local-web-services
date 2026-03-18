package io.localwebservices.lws.middleware;

import com.sun.net.httpserver.HttpExchange;
import io.localwebservices.lws.ServerState;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

/**
 * Fake response middleware. Checks whether a configured fake rule matches the current operation and
 * short-circuits the request with the fake response if so.
 */
public class FakeMiddleware {

  /**
   * Apply fake response rules.
   *
   * @return true if a fake rule matched and the response was sent (request should not be processed
   *     further)
   */
  @SuppressWarnings({"unchecked", "PMD.AvoidBranchingStatementAsLastInLoop"})
  public static boolean applyFake(
      ServerState state, String service, String operation, HttpExchange exchange)
      throws IOException, InterruptedException {
    Map<String, Object> serviceConfig = state.fakeRules.get(service);
    if (serviceConfig == null) return false;

    Boolean enabled = (Boolean) serviceConfig.get("enabled");
    if (!Boolean.TRUE.equals(enabled)) return false;

    List<Map<String, Object>> rules = (List<Map<String, Object>>) serviceConfig.get("rules");
    if (rules == null || rules.isEmpty()) return false;

    // Convert PascalCase operation to kebab-case for matching
    String opKebab = toKebabCase(operation);

    boolean matched = false;
    for (Map<String, Object> rule : rules) {
      String ruleOp = (String) rule.get("operation");
      if (ruleOp == null) continue;
      if (!ruleOp.equalsIgnoreCase(opKebab) && !ruleOp.equalsIgnoreCase(operation)) continue;

      // Match found
      Map<String, Object> response = (Map<String, Object>) rule.get("response");
      if (response == null) continue;

      int status =
          response.containsKey("status") ? ((Number) response.get("status")).intValue() : 200;
      String contentType = (String) response.getOrDefault("content_type", "application/json");
      String body = (String) response.getOrDefault("body", "{}");
      int delayMs =
          response.containsKey("delay_ms") ? ((Number) response.get("delay_ms")).intValue() : 0;

      if (delayMs > 0) Thread.sleep(delayMs);

      byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
      exchange.getResponseHeaders().set("Content-Type", contentType);
      exchange.sendResponseHeaders(status, bytes.length);
      try (OutputStream os = exchange.getResponseBody()) {
        os.write(bytes);
      }
      matched = true;
      break;
    }
    return matched;
  }

  private static String toKebabCase(String pascalCase) {
    return pascalCase.replaceAll("([A-Z])", "-$1").toLowerCase().replaceFirst("^-", "");
  }
}
