package io.localwebservices.lws.providers.organizations;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/** In-memory AWS Organizations state. */
public class OrganizationsStore {

  static final String ACCOUNT_ID = "000000000000";

  private static final AtomicLong ORG_COUNTER = new AtomicLong(0);
  private static final AtomicLong ROOT_COUNTER = new AtomicLong(0);
  private static final AtomicLong OU_COUNTER = new AtomicLong(0);
  private static final AtomicLong POLICY_COUNTER = new AtomicLong(0);
  private static final AtomicLong ACCOUNT_COUNTER = new AtomicLong(0);

  private Map<String, Object> organization = null;
  private Map<String, Object> root = null;
  private final Map<String, Map<String, Object>> ous = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> accounts = new ConcurrentHashMap<>();
  private final Map<String, String> accountParents = new ConcurrentHashMap<>();
  private final Map<String, Map<String, Object>> policies = new ConcurrentHashMap<>();
  private final Map<String, Set<String>> policyAttachments = new ConcurrentHashMap<>();

  public void reset() {
    organization = null;
    root = null;
    ous.clear();
    accounts.clear();
    accountParents.clear();
    policies.clear();
    policyAttachments.clear();
  }

  // --- ID generation ---

  private static String nextOrgId() {
    return String.format("o-%04x", ORG_COUNTER.incrementAndGet());
  }

  private static String nextRootId() {
    return String.format("r-%04x", ROOT_COUNTER.incrementAndGet());
  }

  private static String nextOuId() {
    return String.format("ou-%08x", OU_COUNTER.incrementAndGet());
  }

  private static String nextPolicyId() {
    return String.format("p-%08x", POLICY_COUNTER.incrementAndGet());
  }

  private static String nextAccountId() {
    return String.format("%012d", ACCOUNT_COUNTER.incrementAndGet());
  }

  // --- ARN helpers ---

  private static String orgArn(String orgId) {
    return "arn:aws:organizations::" + ACCOUNT_ID + ":organization/" + orgId;
  }

  private static String rootArn(String orgId, String rootId) {
    return "arn:aws:organizations::" + ACCOUNT_ID + ":root/" + orgId + "/" + rootId;
  }

  private static String ouArn(String orgId, String ouId) {
    return "arn:aws:organizations::" + ACCOUNT_ID + ":ou/" + orgId + "/" + ouId;
  }

  private static String accountArn(String acctId) {
    return "arn:aws:organizations::" + ACCOUNT_ID + ":account/" + acctId;
  }

  private static String policyArn(String orgId, String polId) {
    return "arn:aws:organizations::"
        + ACCOUNT_ID
        + ":policy/"
        + orgId
        + "/service_control_policy/"
        + polId;
  }

  // --- Queries ---

  public boolean hasOrganization() {
    return organization != null;
  }

  public Map<String, Object> getOrganization() {
    return organization;
  }

  public Map<String, Object> getRoot() {
    return root;
  }

  public boolean parentExists(String parentId) {
    if (root != null && parentId.equals(root.get("Id"))) return true;
    return ous.containsKey(parentId);
  }

  public String targetType(String targetId) {
    if (root != null && targetId.equals(root.get("Id"))) return "ROOT";
    if (ous.containsKey(targetId)) return "ORGANIZATIONAL_UNIT";
    if (accounts.containsKey(targetId)) return "ACCOUNT";
    return null;
  }

  public boolean ouHasChildren(String ouId) {
    for (String parentId : accountParents.values()) {
      if (ouId.equals(parentId)) return true;
    }
    for (Map<String, Object> ou : ous.values()) {
      if (ouId.equals(ou.get("ParentId"))) return true;
    }
    return false;
  }

  public boolean ouHasAttachedPolicies(String ouId) {
    for (Set<String> targets : policyAttachments.values()) {
      if (targets.contains(ouId)) return true;
    }
    return false;
  }

  public boolean emailInUse(String email) {
    for (Map<String, Object> acct : accounts.values()) {
      if (email.equals(acct.get("Email"))) return true;
    }
    return false;
  }

  public boolean hasAccount(String accountId) {
    return accounts.containsKey(accountId);
  }

  public Map<String, Object> getAccount(String accountId) {
    return accounts.get(accountId);
  }

  public List<Map<String, Object>> getAllAccounts() {
    return new ArrayList<>(accounts.values());
  }

  public List<Object> getAccountsForParent(String parentId) {
    List<Object> result = new ArrayList<>();
    for (Map.Entry<String, Map<String, Object>> e : accounts.entrySet()) {
      if (parentId.equals(accountParents.get(e.getKey()))) result.add(e.getValue());
    }
    return result;
  }

  public String getAccountParent(String accountId) {
    return accountParents.get(accountId);
  }

  public boolean hasOu(String ouId) {
    return ous.containsKey(ouId);
  }

  public Map<String, Object> getOu(String ouId) {
    return ous.get(ouId);
  }

  public List<Object> getOusForParent(String parentId) {
    List<Object> result = new ArrayList<>();
    for (Map<String, Object> ou : ous.values()) {
      if (parentId.equals(ou.get("ParentId"))) result.add(ou);
    }
    return result;
  }

  public boolean ouNameExists(String parentId, String name) {
    for (Map<String, Object> ou : ous.values()) {
      if (parentId.equals(ou.get("ParentId")) && name.equals(ou.get("Name"))) return true;
    }
    return false;
  }

  public boolean hasPolicy(String policyId) {
    return policies.containsKey(policyId);
  }

  public Map<String, Object> getPolicy(String policyId) {
    return policies.get(policyId);
  }

  public boolean policyNameExists(String name, String type) {
    for (Map<String, Object> pol : policies.values()) {
      @SuppressWarnings("unchecked")
      Map<String, Object> summary = (Map<String, Object>) pol.get("PolicySummary");
      if (name.equals(summary.get("Name")) && type.equals(summary.get("Type"))) return true;
    }
    return false;
  }

  @SuppressWarnings("unchecked")
  public List<Object> listPolicies(String filter) {
    List<Object> result = new ArrayList<>();
    for (Map<String, Object> pol : policies.values()) {
      Map<String, Object> s = (Map<String, Object>) pol.get("PolicySummary");
      if (filter.isEmpty() || filter.equals(s.get("Type"))) result.add(s);
    }
    return result;
  }

  public boolean hasPolicyAttachment(String policyId, String targetId) {
    Set<String> targets = policyAttachments.get(policyId);
    return targets != null && targets.contains(targetId);
  }

  @SuppressWarnings("unchecked")
  public List<Object> listPoliciesForTarget(String targetId, String filter) {
    List<Object> result = new ArrayList<>();
    for (Map.Entry<String, Set<String>> e : policyAttachments.entrySet()) {
      if (!e.getValue().contains(targetId)) continue;
      Map<String, Object> pol = policies.get(e.getKey());
      if (pol == null) continue;
      Map<String, Object> s = (Map<String, Object>) pol.get("PolicySummary");
      if (!filter.isEmpty() && !filter.equals(s.get("Type"))) continue;
      result.add(s);
    }
    return result;
  }

  public List<Object> listTargetsForPolicy(String policyId) {
    List<Object> result = new ArrayList<>();
    for (String targetId : policyAttachments.getOrDefault(policyId, Set.of())) {
      String ttype = targetType(targetId);
      if (ttype != null) result.add(Map.of("TargetId", targetId, "Type", ttype));
    }
    return result;
  }

  // --- Mutations ---

  public Map<String, Object> createOrganization(String featureSet) {
    String orgId = nextOrgId();
    String rootId = nextRootId();
    Map<String, Object> org = new LinkedHashMap<>();
    org.put("Id", orgId);
    org.put("Arn", orgArn(orgId));
    org.put("FeatureSet", featureSet);
    org.put("MasterAccountId", ACCOUNT_ID);
    org.put(
        "MasterAccountArn",
        "arn:aws:organizations::" + ACCOUNT_ID + ":account/" + orgId + "/" + ACCOUNT_ID);
    org.put("MasterAccountEmail", "master@example.com");
    org.put(
        "AvailablePolicyTypes",
        List.of(Map.of("Type", "SERVICE_CONTROL_POLICY", "Status", "ENABLED")));
    Map<String, Object> r = new LinkedHashMap<>();
    r.put("Id", rootId);
    r.put("Arn", rootArn(orgId, rootId));
    r.put("Name", "Root");
    r.put("PolicyTypes", List.of(Map.of("Type", "SERVICE_CONTROL_POLICY", "Status", "ENABLED")));
    organization = org;
    root = r;
    return org;
  }

  public Map<String, Object> createAccount(String name, String email) {
    String acctId = nextAccountId();
    double ts = System.currentTimeMillis() / 1000.0;
    Map<String, Object> acct = new LinkedHashMap<>();
    acct.put("Id", acctId);
    acct.put("Arn", accountArn(acctId));
    acct.put("Name", name);
    acct.put("Email", email);
    acct.put("Status", "ACTIVE");
    acct.put("JoinedMethod", "CREATED");
    acct.put("JoinedTimestamp", ts);
    accounts.put(acctId, acct);
    accountParents.put(acctId, (String) root.get("Id"));
    return acct;
  }

  public Map<String, Object> createOu(String parentId, String name) {
    String orgId = (String) organization.get("Id");
    String ouId = nextOuId();
    Map<String, Object> ou = new LinkedHashMap<>();
    ou.put("Id", ouId);
    ou.put("Arn", ouArn(orgId, ouId));
    ou.put("Name", name);
    ou.put("ParentId", parentId);
    ous.put(ouId, ou);
    return ou;
  }

  public void removeOu(String ouId) {
    ous.remove(ouId);
  }

  public void moveAccount(String accountId, String destinationParentId) {
    accountParents.put(accountId, destinationParentId);
  }

  public Map<String, Object> createPolicy(
      String name, String description, String content, String type) {
    String orgId = (String) organization.get("Id");
    String polId = nextPolicyId();
    Map<String, Object> summary = new LinkedHashMap<>();
    summary.put("Id", polId);
    summary.put("Arn", policyArn(orgId, polId));
    summary.put("Name", name);
    summary.put("Description", description);
    summary.put("Type", type);
    summary.put("AwsManaged", false);
    Map<String, Object> policy = new LinkedHashMap<>();
    policy.put("PolicySummary", summary);
    policy.put("Content", content);
    policies.put(polId, policy);
    return policy;
  }

  public void addPolicyAttachment(String policyId, String targetId) {
    policyAttachments.computeIfAbsent(policyId, k -> ConcurrentHashMap.newKeySet()).add(targetId);
  }

  public void removePolicyAttachment(String policyId, String targetId) {
    Set<String> targets = policyAttachments.get(policyId);
    if (targets != null) targets.remove(targetId);
  }
}
