package io.localwebservices.lws.middleware;

import com.sun.net.httpserver.HttpExchange;
import io.localwebservices.lws.ServerState;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/** IAM policy evaluation middleware. */
public class IamMiddleware {

  private static final Pattern CREDENTIAL_PATTERN = Pattern.compile("Credential=([^/,]+)");

  /**
   * Apply IAM auth rules.
   *
   * @return true if access is denied and the request should not be processed further.
   */
  @SuppressWarnings("unchecked")
  public static boolean applyIamAuth(
      ServerState state,
      String service,
      String operation,
      HttpExchange exchange,
      boolean xmlProtocol)
      throws IOException {
    if (!state.iamEnforce) return false;

    // Extract access key from Authorization header
    String authHeader = exchange.getRequestHeaders().getFirst("Authorization");
    if (authHeader == null) authHeader = "";
    Matcher m = CREDENTIAL_PATTERN.matcher(authHeader);
    String accessKeyId = m.find() ? m.group(1) : "anonymous";

    String action = service.toLowerCase() + ":" + operation;
    String resource = "*";

    if (!isAuthorized(state, accessKeyId, action, resource)) {
      if (xmlProtocol) {
        String xml =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Error><Code>AccessDenied</Code><Message>Access Denied: User is not authorized to perform: "
                + action
                + "</Message></Error>";
        ChaosMiddleware.sendResponse(exchange, 403, "application/xml", xml);
      } else {
        String json =
            "{\"__type\":\"AccessDeniedException\",\"message\":\"User: arn:aws:iam::000000000000:user/"
                + accessKeyId
                + " is not authorized to perform: "
                + action
                + "\"}";
        ChaosMiddleware.sendResponse(exchange, 403, "application/x-amz-json-1.0", json);
      }
      return true;
    }
    return false;
  }

  @SuppressWarnings("unchecked")
  private static boolean isAuthorized(
      ServerState state, String accessKeyId, String action, String resource) {
    String defaultIdentity = state.iamDefaultIdentity;

    Map<String, Object> identity = (Map<String, Object>) state.iamIdentities.get(accessKeyId);
    if (identity == null && defaultIdentity != null) {
      identity = (Map<String, Object>) state.iamIdentities.get(defaultIdentity);
    }
    if (identity == null) {
      identity = (Map<String, Object>) state.iamIdentities.get("default");
    }

    if (identity == null) return false;

    List<Map<String, Object>> inlinePolicies =
        (List<Map<String, Object>>) identity.get("inline_policies");
    Map<String, Object> permissionBoundary =
        (Map<String, Object>) identity.get("permission_boundary");

    // Check explicit denies
    if (inlinePolicies != null) {
      for (Map<String, Object> policy : inlinePolicies) {
        List<Map<String, Object>> statements = (List<Map<String, Object>>) policy.get("Statement");
        if (statements != null) {
          for (Map<String, Object> stmt : statements) {
            if ("Deny".equals(stmt.get("Effect"))) {
              if (statementMatches(stmt, action, resource)) return false;
            }
          }
        }
      }
    }

    // Check permission boundary
    if (permissionBoundary != null) {
      if (evaluatePolicy(permissionBoundary, action, resource) != PolicyResult.ALLOW) return false;
    }

    // Check inline policies for allow
    if (inlinePolicies != null) {
      for (Map<String, Object> policy : inlinePolicies) {
        if (evaluatePolicy(policy, action, resource) == PolicyResult.ALLOW) return true;
      }
    }

    return false;
  }

  enum PolicyResult {
    ALLOW,
    DENY,
    NO_MATCH
  }

  @SuppressWarnings("unchecked")
  private static PolicyResult evaluatePolicy(
      Map<String, Object> policy, String action, String resource) {
    List<Map<String, Object>> statements = (List<Map<String, Object>>) policy.get("Statement");
    if (statements == null) return PolicyResult.NO_MATCH;

    PolicyResult result = PolicyResult.NO_MATCH;
    for (Map<String, Object> stmt : statements) {
      String effect = (String) stmt.get("Effect");
      if (statementMatches(stmt, action, resource)) {
        if ("Deny".equals(effect)) return PolicyResult.DENY;
        if ("Allow".equals(effect)) result = PolicyResult.ALLOW;
      }
    }
    return result;
  }

  @SuppressWarnings("unchecked")
  private static boolean statementMatches(
      Map<String, Object> stmt, String action, String resource) {
    Object actionObj = stmt.get("Action");
    Object resourceObj = stmt.get("Resource");

    List<String> actions = toList(actionObj);
    List<String> resources = toList(resourceObj);

    boolean actionMatch = actions.stream().anyMatch(a -> wildcardMatch(a, action));
    boolean resourceMatch = resources.stream().anyMatch(r -> wildcardMatch(r, resource));

    return actionMatch && resourceMatch;
  }

  private static List<String> toList(Object obj) {
    if (obj instanceof List) {
      List<?> list = (List<?>) obj;
      List<String> result = new ArrayList<>();
      for (Object item : list) result.add(String.valueOf(item));
      return result;
    } else if (obj != null) {
      return Collections.singletonList(String.valueOf(obj));
    }
    return Collections.emptyList();
  }

  private static boolean wildcardMatch(String pattern, String value) {
    // Convert wildcard pattern to regex
    String escaped =
        pattern
            .replace(".", "\\.")
            .replace("+", "\\+")
            .replace("^", "\\^")
            .replace("$", "\\$")
            .replace("{", "\\{")
            .replace("}", "\\}")
            .replace("(", "\\(")
            .replace(")", "\\)")
            .replace("[", "\\[")
            .replace("]", "\\]")
            .replace("\\", "\\\\");
    String regex = "^" + escaped.replace("*", ".*").replace("?", ".") + "$";
    return value.matches("(?i)" + regex);
  }
}
