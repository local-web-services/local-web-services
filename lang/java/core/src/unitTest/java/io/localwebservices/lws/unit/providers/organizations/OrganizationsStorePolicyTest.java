package io.localwebservices.lws.unit.providers.organizations;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.organizations.OrganizationsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class OrganizationsStorePolicyTest {

  private static final String SCP = "SERVICE_CONTROL_POLICY";

  private OrganizationsStore storeWithOrg() {
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");
    return store;
  }

  @Test
  public void createPolicy_newPolicy_returnsPolicyWithId() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedName = "test-policy";
    String expectedType = SCP;

    // Act
    Map<String, Object> actualPolicy = store.createPolicy(expectedName, "desc", "{}", expectedType);

    // Assert
    @SuppressWarnings("unchecked")
    Map<String, Object> actualSummary = (Map<String, Object>) actualPolicy.get("PolicySummary");
    assertNotNull(actualSummary.get("Id"), "Expected policy Id to not be null");
    assertEquals(expectedName, actualSummary.get("Name"), "Expected Name to match");
    assertEquals(expectedType, actualSummary.get("Type"), "Expected Type to match");
  }

  @Test
  public void hasPolicy_afterCreate_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedId = (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");

    // Act
    boolean actualResult = store.hasPolicy(expectedId);

    // Assert
    assertTrue(actualResult, "Expected hasPolicy to be true after creation");
  }

  @Test
  public void hasPolicy_missingId_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    boolean actualResult = store.hasPolicy("nonexistent");

    // Assert
    assertFalse(actualResult, "Expected hasPolicy to be false for missing id");
  }

  @Test
  public void getPolicy_existingId_returnsPolicy() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> expected = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedId = (String) ((Map<String, Object>) expected.get("PolicySummary")).get("Id");

    // Act
    Map<String, Object> actualPolicy = store.getPolicy(expectedId);

    // Assert
    assertNotNull(actualPolicy, "Expected policy to not be null");
  }

  @Test
  public void getPolicy_missingId_returnsNull() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    Map<String, Object> actualPolicy = store.getPolicy("nonexistent");

    // Assert
    assertNull(actualPolicy, "Expected null for missing policy");
  }

  @Test
  public void policyNameExists_duplicateNameAndType_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedName = "duplicate";
    store.createPolicy(expectedName, "desc", "{}", SCP);

    // Act
    boolean actualResult = store.policyNameExists(expectedName, SCP);

    // Assert
    assertTrue(actualResult, "Expected policyNameExists to be true for duplicate name+type");
  }

  @Test
  public void policyNameExists_differentName_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createPolicy("existing", "desc", "{}", SCP);

    // Act
    boolean actualResult = store.policyNameExists("other", SCP);

    // Assert
    assertFalse(actualResult, "Expected policyNameExists to be false for different name");
  }

  @Test
  public void listPolicies_noFilter_returnsAll() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createPolicy("p1", "desc", "{}", SCP);
    store.createPolicy("p2", "desc", "{}", SCP);
    int expectedSize = 2;

    // Act
    List<Object> actualPolicies = store.listPolicies("");

    // Assert
    assertEquals(expectedSize, actualPolicies.size(), "Expected listPolicies to return all");
  }

  @Test
  public void listPolicies_withFilter_returnsMatching() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createPolicy("p1", "desc", "{}", SCP);
    int expectedSize = 1;

    // Act
    List<Object> actualPolicies = store.listPolicies(SCP);

    // Assert
    assertEquals(expectedSize, actualPolicies.size(), "Expected listPolicies to return matching");
  }

  @Test
  public void addPolicyAttachment_newAttachment_hasPolicyAttachmentReturnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    String expectedTargetId = (String) store.getRoot().get("Id");

    // Act
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);

    // Assert
    assertTrue(
        store.hasPolicyAttachment(expectedPolicyId, expectedTargetId),
        "Expected hasPolicyAttachment to be true after attach");
  }

  @Test
  public void hasPolicyAttachment_noAttachment_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");

    // Act
    boolean actualResult = store.hasPolicyAttachment(expectedPolicyId, "some-target");

    // Assert
    assertFalse(actualResult, "Expected hasPolicyAttachment to be false before attach");
  }

  @Test
  public void removePolicyAttachment_existingAttachment_removesIt() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    String expectedTargetId = (String) store.getRoot().get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);

    // Act
    store.removePolicyAttachment(expectedPolicyId, expectedTargetId);

    // Assert
    assertFalse(
        store.hasPolicyAttachment(expectedPolicyId, expectedTargetId),
        "Expected hasPolicyAttachment to be false after detach");
  }

  @Test
  public void removePolicyAttachment_nonExistentPolicy_doesNotThrow() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act & Assert
    store.removePolicyAttachment("nonexistent-policy", "some-target");
  }

  @Test
  public void policyNameExists_sameNameDifferentType_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedName = "test-policy";
    store.createPolicy(expectedName, "desc", "{}", SCP);

    // Act
    boolean actualResult = store.policyNameExists(expectedName, "TAG_POLICY");

    // Assert
    assertFalse(actualResult, "Expected policyNameExists to be false when type differs");
  }

  @Test
  public void listPolicies_withFilterNoMatch_returnsEmpty() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createPolicy("p1", "desc", "{}", SCP);
    int expectedSize = 0;

    // Act
    List<Object> actualPolicies = store.listPolicies("TAG_POLICY");

    // Assert
    assertEquals(
        expectedSize,
        actualPolicies.size(),
        "Expected empty list when filter does not match any policy");
  }

  @Test
  public void hasPolicyAttachment_attachmentExistsForOtherTarget_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    String expectedRootId = (String) store.getRoot().get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedRootId);

    // Act
    boolean actualResult = store.hasPolicyAttachment(expectedPolicyId, "other-target");

    // Assert
    assertFalse(actualResult, "Expected false when policy is attached to a different target");
  }

  @Test
  public void ouHasAttachedPolicies_policyAttached_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedOuId);

    // Act
    boolean actualResult = store.ouHasAttachedPolicies(expectedOuId);

    // Assert
    assertTrue(actualResult, "Expected ouHasAttachedPolicies to be true when policy attached");
  }

  @Test
  public void ouHasAttachedPolicies_policyAttachedToOtherTarget_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    String expectedRootId = (String) store.getRoot().get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedRootId);

    // Act
    boolean actualResult = store.ouHasAttachedPolicies(expectedOuId);

    // Assert
    assertFalse(actualResult, "Expected false when policy is attached to a different target");
  }

  @Test
  public void ouHasAttachedPolicies_noAttachment_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    boolean actualResult = store.ouHasAttachedPolicies(expectedOuId);

    // Assert
    assertFalse(actualResult, "Expected ouHasAttachedPolicies to be false when no policy attached");
  }

  @Test
  public void listPoliciesForTarget_withMatchingPolicy_returnsPolicy() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);
    int expectedSize = 1;

    // Act
    List<Object> actualPolicies = store.listPoliciesForTarget(expectedTargetId, "");

    // Assert
    assertEquals(expectedSize, actualPolicies.size(), "Expected one policy for target");
  }

  @Test
  public void listPoliciesForTarget_withFilterMismatch_returnsEmpty() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);

    // Act
    List<Object> actualPolicies = store.listPoliciesForTarget(expectedTargetId, "OTHER_TYPE");

    // Assert
    assertEquals(0, actualPolicies.size(), "Expected no policies when filter does not match");
  }

  @Test
  public void listTargetsForPolicy_withAttachment_returnsTarget() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);
    int expectedSize = 1;

    // Act
    List<Object> actualTargets = store.listTargetsForPolicy(expectedPolicyId);

    // Assert
    assertEquals(expectedSize, actualTargets.size(), "Expected one target for policy");
  }

  @Test
  public void listPoliciesForTarget_withOrphanedPolicyId_isSkipped() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    store.addPolicyAttachment("nonexistent-policy-id", expectedTargetId);
    int expectedSize = 0;

    // Act
    List<Object> actualPolicies = store.listPoliciesForTarget(expectedTargetId, "");

    // Assert
    assertEquals(
        expectedSize,
        actualPolicies.size(),
        "Expected empty list when policy id in attachment does not exist");
  }

  @Test
  public void listPoliciesForTarget_withFilterMatch_returnsPolicy() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);
    int expectedSize = 1;

    // Act
    List<Object> actualPolicies = store.listPoliciesForTarget(expectedTargetId, SCP);

    // Assert
    assertEquals(
        expectedSize, actualPolicies.size(), "Expected one policy when filter matches policy type");
  }

  @Test
  public void listPoliciesForTarget_withMultipleAttachmentsOneMatchesTarget_returnsOne() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedTargetId = (String) store.getRoot().get("Id");
    Map<String, Object> ou = store.createOu(expectedTargetId, "test-ou");
    String expectedOuId = (String) ou.get("Id");
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, expectedTargetId);
    store.addPolicyAttachment(expectedPolicyId, expectedOuId);
    int expectedSize = 1;

    // Act
    List<Object> actualPolicies = store.listPoliciesForTarget(expectedOuId, "");

    // Assert
    assertEquals(
        expectedSize,
        actualPolicies.size(),
        "Expected one policy when one attachment matches target");
  }

  @Test
  public void listTargetsForPolicy_withNonExistentTarget_isSkipped() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");
    store.addPolicyAttachment(expectedPolicyId, "nonexistent-target-id");
    int expectedSize = 0;

    // Act
    List<Object> actualTargets = store.listTargetsForPolicy(expectedPolicyId);

    // Assert
    assertEquals(
        expectedSize, actualTargets.size(), "Expected empty list when target id does not exist");
  }

  @Test
  public void listTargetsForPolicy_noAttachments_returnsEmpty() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");

    // Act
    List<Object> actualTargets = store.listTargetsForPolicy(expectedPolicyId);

    // Assert
    assertEquals(0, actualTargets.size(), "Expected no targets when no attachments");
  }

  @Test
  public void reset_clearsPolicies() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> policy = store.createPolicy("test", "desc", "{}", SCP);
    @SuppressWarnings("unchecked")
    String expectedPolicyId =
        (String) ((Map<String, Object>) policy.get("PolicySummary")).get("Id");

    // Act
    store.reset();

    // Assert
    assertFalse(store.hasPolicy(expectedPolicyId), "Expected policies to be cleared after reset");
  }
}
