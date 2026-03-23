package io.localwebservices.lws.providers.organizations;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import java.io.*;
import java.util.*;

/** AWS Organizations wire-protocol HTTP handler. */
public class OrganizationsHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final String TARGET_PREFIX = "AWSOrganizationsV20161128.";

  private final ServerState state;
  private final OrganizationsStore store;

  public OrganizationsHandler(ServerState state) {
    this.state = state;
    this.store = new OrganizationsStore();
    state.resetCallbacks.add(store::reset);
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null) target = "";
    String operation =
        target.startsWith(TARGET_PREFIX) ? target.substring(TARGET_PREFIX.length()) : target;

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    try {
      if (ChaosMiddleware.applyChaos(state, "organizations", operation, exchange, false)) return;
      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "InternalFailure",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    }
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateOrganization":
        if (store.hasOrganization()) {
          sendError(
              exchange,
              409,
              "AlreadyInOrganizationException",
              "The account is already a member of an organization.");
          return;
        }
        String featureSet = str(body, "FeatureSet");
        if (featureSet.isEmpty()) featureSet = "ALL";
        sendJson(exchange, 200, Map.of("Organization", store.createOrganization(featureSet)));
        break;

      case "DescribeOrganization":
        if (!store.hasOrganization()) {
          sendError(
              exchange,
              400,
              "AWSOrganizationsNotInUseException",
              "Your account is not a member of an organization.");
          return;
        }
        sendJson(exchange, 200, Map.of("Organization", store.getOrganization()));
        break;

      case "ListRoots":
        List<Object> roots = store.getRoot() != null ? List.of(store.getRoot()) : List.of();
        sendJson(exchange, 200, Map.of("Roots", roots));
        break;

      case "CreateAccount":
        if (!store.hasOrganization()) {
          sendError(
              exchange,
              400,
              "AWSOrganizationsNotInUseException",
              "Your account is not a member of an organization.");
          return;
        }
        String email = str(body, "Email");
        if (store.emailInUse(email)) {
          sendError(
              exchange,
              409,
              "DuplicateAccountException",
              "An account with email '" + email + "' already exists.");
          return;
        }
        String acctName = str(body, "AccountName");
        Map<String, Object> acct = store.createAccount(acctName, email);
        double ts = (double) acct.get("JoinedTimestamp");
        sendJson(
            exchange,
            200,
            Map.of(
                "CreateAccountStatus",
                Map.of(
                    "State",
                    "SUCCEEDED",
                    "AccountId",
                    acct.get("Id"),
                    "AccountName",
                    acctName,
                    "RequestedTimestamp",
                    ts)));
        break;

      case "DescribeAccount":
        String acctId = str(body, "AccountId");
        Map<String, Object> foundAcct = store.getAccount(acctId);
        if (foundAcct == null) {
          sendError(
              exchange,
              400,
              "AccountNotFoundException",
              "Account '" + acctId + "' does not exist.");
          return;
        }
        sendJson(exchange, 200, Map.of("Account", foundAcct));
        break;

      case "ListAccounts":
        sendJson(exchange, 200, Map.of("Accounts", store.getAllAccounts()));
        break;

      case "ListAccountsForParent":
        sendJson(
            exchange, 200, Map.of("Accounts", store.getAccountsForParent(str(body, "ParentId"))));
        break;

      case "CreateOrganizationalUnit":
        if (!store.hasOrganization()) {
          sendError(
              exchange,
              400,
              "AWSOrganizationsNotInUseException",
              "Your account is not a member of an organization.");
          return;
        }
        String parentId = str(body, "ParentId");
        String ouName = str(body, "Name");
        if (!store.parentExists(parentId)) {
          sendError(
              exchange,
              400,
              "ParentNotFoundException",
              "Parent '" + parentId + "' does not exist.");
          return;
        }
        if (store.ouNameExists(parentId, ouName)) {
          sendError(
              exchange,
              409,
              "DuplicateOrganizationalUnitException",
              "An OU named '" + ouName + "' already exists under parent '" + parentId + "'.");
          return;
        }
        sendJson(exchange, 200, Map.of("OrganizationalUnit", store.createOu(parentId, ouName)));
        break;

      case "DescribeOrganizationalUnit":
        String ouId = str(body, "OrganizationalUnitId");
        Map<String, Object> ou = store.getOu(ouId);
        if (ou == null) {
          sendError(
              exchange,
              400,
              "OrganizationalUnitNotFoundException",
              "Organizational unit '" + ouId + "' does not exist.");
          return;
        }
        sendJson(exchange, 200, Map.of("OrganizationalUnit", ou));
        break;

      case "ListOrganizationalUnitsForParent":
        sendJson(
            exchange,
            200,
            Map.of("OrganizationalUnits", store.getOusForParent(str(body, "ParentId"))));
        break;

      case "DeleteOrganizationalUnit":
        String deleteOuId = str(body, "OrganizationalUnitId");
        if (!store.hasOu(deleteOuId)) {
          sendError(
              exchange,
              400,
              "OrganizationalUnitNotFoundException",
              "Organizational unit '" + deleteOuId + "' does not exist.");
          return;
        }
        if (store.ouHasChildren(deleteOuId)) {
          sendError(
              exchange,
              400,
              "OrganizationalUnitNotEmptyException",
              "Organizational unit '" + deleteOuId + "' is not empty.");
          return;
        }
        if (store.ouHasAttachedPolicies(deleteOuId)) {
          sendError(
              exchange,
              400,
              "PolicyChangesInProgressException",
              "Organizational unit '" + deleteOuId + "' has policies attached.");
          return;
        }
        store.removeOu(deleteOuId);
        sendJson(exchange, 200, Map.of());
        break;

      case "MoveAccount":
        String moveAcctId = str(body, "AccountId");
        String srcId = str(body, "SourceParentId");
        String dstId = str(body, "DestinationParentId");
        if (!store.hasAccount(moveAcctId)) {
          sendError(
              exchange,
              400,
              "AccountNotFoundException",
              "Account '" + moveAcctId + "' does not exist.");
          return;
        }
        if (!srcId.equals(store.getAccountParent(moveAcctId))) {
          sendError(
              exchange,
              400,
              "SourceParentNotFoundException",
              "Account '" + moveAcctId + "' is not under source parent '" + srcId + "'.");
          return;
        }
        if (!store.parentExists(dstId)) {
          sendError(
              exchange,
              400,
              "DestinationParentNotFoundException",
              "Destination parent '" + dstId + "' does not exist.");
          return;
        }
        store.moveAccount(moveAcctId, dstId);
        sendJson(exchange, 200, Map.of());
        break;

      case "CreatePolicy":
        if (!store.hasOrganization()) {
          sendError(
              exchange,
              400,
              "AWSOrganizationsNotInUseException",
              "Your account is not a member of an organization.");
          return;
        }
        String polName = str(body, "Name");
        String polType = str(body, "Type");
        if (polType.isEmpty()) polType = "SERVICE_CONTROL_POLICY";
        if (store.policyNameExists(polName, polType)) {
          sendError(
              exchange,
              409,
              "DuplicatePolicyException",
              "A policy named '" + polName + "' of type '" + polType + "' already exists.");
          return;
        }
        String content = str(body, "Content");
        if (content.isEmpty()) content = "{}";
        sendJson(
            exchange,
            200,
            Map.of(
                "Policy", store.createPolicy(polName, str(body, "Description"), content, polType)));
        break;

      case "DescribePolicy":
        String descPolId = str(body, "PolicyId");
        Map<String, Object> pol = store.getPolicy(descPolId);
        if (pol == null) {
          sendError(
              exchange,
              400,
              "PolicyNotFoundException",
              "Policy '" + descPolId + "' does not exist.");
          return;
        }
        sendJson(exchange, 200, Map.of("Policy", pol));
        break;

      case "ListPolicies":
        sendJson(exchange, 200, Map.of("Policies", store.listPolicies(str(body, "Filter"))));
        break;

      case "AttachPolicy":
        String attachPolId = str(body, "PolicyId");
        String attachTargetId = str(body, "TargetId");
        if (!store.hasPolicy(attachPolId)) {
          sendError(
              exchange,
              400,
              "PolicyNotFoundException",
              "Policy '" + attachPolId + "' does not exist.");
          return;
        }
        if (store.targetType(attachTargetId) == null) {
          sendError(
              exchange,
              400,
              "TargetNotFoundException",
              "Target '" + attachTargetId + "' does not exist.");
          return;
        }
        if (store.hasPolicyAttachment(attachPolId, attachTargetId)) {
          sendError(
              exchange,
              409,
              "DuplicatePolicyAttachmentException",
              "Policy '"
                  + attachPolId
                  + "' is already attached to target '"
                  + attachTargetId
                  + "'.");
          return;
        }
        store.addPolicyAttachment(attachPolId, attachTargetId);
        sendJson(exchange, 200, Map.of());
        break;

      case "DetachPolicy":
        String detachPolId = str(body, "PolicyId");
        String detachTargetId = str(body, "TargetId");
        if (!store.hasPolicyAttachment(detachPolId, detachTargetId)) {
          sendError(
              exchange,
              400,
              "PolicyNotAttachedException",
              "Policy '" + detachPolId + "' is not attached to target '" + detachTargetId + "'.");
          return;
        }
        store.removePolicyAttachment(detachPolId, detachTargetId);
        sendJson(exchange, 200, Map.of());
        break;

      case "ListPoliciesForTarget":
        sendJson(
            exchange,
            200,
            Map.of(
                "Policies",
                store.listPoliciesForTarget(str(body, "TargetId"), str(body, "Filter"))));
        break;

      case "ListTargetsForPolicy":
        String listPolId = str(body, "PolicyId");
        if (!store.hasPolicy(listPolId)) {
          sendError(
              exchange,
              400,
              "PolicyNotFoundException",
              "Policy '" + listPolId + "' does not exist.");
          return;
        }
        sendJson(exchange, 200, Map.of("Targets", store.listTargetsForPolicy(listPolId)));
        break;

      default:
        sendError(
            exchange,
            400,
            "InvalidAction",
            "lws: Organizations operation '" + operation + "' is not yet implemented");
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.1");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }

  private void sendError(HttpExchange exchange, int status, String type, String message)
      throws IOException {
    sendJson(exchange, status, Map.of("__type", type, "message", message));
  }

  private static String str(Map<String, Object> body, String key) {
    Object v = body.get(key);
    return v instanceof String ? (String) v : "";
  }
}
