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

public class OrganizationsStoreOuTest {

  private OrganizationsStore storeWithOrg() {
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");
    return store;
  }

  @Test
  public void createOu_underRoot_returnsOuWithId() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedName = "test-ou";
    String expectedParentId = (String) store.getRoot().get("Id");

    // Act
    Map<String, Object> actualOu = store.createOu(expectedParentId, expectedName);

    // Assert
    assertNotNull(actualOu.get("Id"), "Expected OU Id to not be null");
    assertEquals(expectedName, actualOu.get("Name"), "Expected Name to match");
    assertEquals(expectedParentId, actualOu.get("ParentId"), "Expected ParentId to match");
  }

  @Test
  public void hasOu_afterCreate_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    boolean actualResult = store.hasOu(expectedOuId);

    // Assert
    assertTrue(actualResult, "Expected hasOu to be true after creation");
  }

  @Test
  public void hasOu_missingId_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    boolean actualResult = store.hasOu("nonexistent");

    // Assert
    assertFalse(actualResult, "Expected hasOu to be false for missing id");
  }

  @Test
  public void getOu_existingId_returnsOu() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> expected = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) expected.get("Id");

    // Act
    Map<String, Object> actualOu = store.getOu(expectedOuId);

    // Assert
    assertNotNull(actualOu, "Expected OU to not be null");
    assertEquals(expectedOuId, actualOu.get("Id"), "Expected Id to match");
  }

  @Test
  public void getOu_missingId_returnsNull() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    Map<String, Object> actualOu = store.getOu("nonexistent");

    // Assert
    assertNull(actualOu, "Expected null for missing OU");
  }

  @Test
  public void getOusForParent_returnsMatchingOus() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedParentId = (String) store.getRoot().get("Id");
    store.createOu(expectedParentId, "ou-a");
    store.createOu(expectedParentId, "ou-b");
    int expectedSize = 2;

    // Act
    List<Object> actualOus = store.getOusForParent(expectedParentId);

    // Assert
    assertEquals(expectedSize, actualOus.size(), "Expected two OUs under root");
  }

  @Test
  public void getOusForParent_ouUnderDifferentParent_returnsEmpty() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> parentOu = store.createOu((String) store.getRoot().get("Id"), "parent");
    String expectedParentOuId = (String) parentOu.get("Id");
    store.createOu((String) store.getRoot().get("Id"), "sibling");
    int expectedSize = 0;

    // Act
    List<Object> actualOus = store.getOusForParent(expectedParentOuId);

    // Assert
    assertEquals(expectedSize, actualOus.size(), "Expected no OUs when none are under this parent");
  }

  @Test
  public void ouNameExists_sameNameDifferentParent_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> parentOu = store.createOu((String) store.getRoot().get("Id"), "parent");
    String expectedParentOuId = (String) parentOu.get("Id");
    String expectedName = "child";
    store.createOu((String) store.getRoot().get("Id"), expectedName);

    // Act
    boolean actualResult = store.ouNameExists(expectedParentOuId, expectedName);

    // Assert
    assertFalse(
        actualResult, "Expected ouNameExists to be false when name exists under different parent");
  }

  @Test
  public void ouHasChildren_accountUnderDifferentOu_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ouA = store.createOu((String) store.getRoot().get("Id"), "ou-a");
    Map<String, Object> ouB = store.createOu((String) store.getRoot().get("Id"), "ou-b");
    String expectedOuAId = (String) ouA.get("Id");
    String expectedOuBId = (String) ouB.get("Id");
    Map<String, Object> account = store.createAccount("child", "child@example.com");
    store.moveAccount((String) account.get("Id"), expectedOuBId);

    // Act
    boolean actualResult = store.ouHasChildren(expectedOuAId);

    // Assert
    assertFalse(
        actualResult, "Expected ouHasChildren to be false when account is under a different OU");
  }

  @Test
  public void ouNameExists_duplicateName_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedParentId = (String) store.getRoot().get("Id");
    String expectedName = "duplicate";
    store.createOu(expectedParentId, expectedName);

    // Act
    boolean actualResult = store.ouNameExists(expectedParentId, expectedName);

    // Assert
    assertTrue(actualResult, "Expected ouNameExists to be true for duplicate name");
  }

  @Test
  public void ouNameExists_differentName_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedParentId = (String) store.getRoot().get("Id");
    store.createOu(expectedParentId, "existing");

    // Act
    boolean actualResult = store.ouNameExists(expectedParentId, "other");

    // Assert
    assertFalse(actualResult, "Expected ouNameExists to be false for different name");
  }

  @Test
  public void removeOu_deletesOu() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    store.removeOu(expectedOuId);

    // Assert
    assertFalse(store.hasOu(expectedOuId), "Expected OU to be removed");
  }

  @Test
  public void ouHasChildren_ouWithChildAccount_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "parent-ou");
    String expectedOuId = (String) ou.get("Id");
    Map<String, Object> account = store.createAccount("child", "child@example.com");
    store.moveAccount((String) account.get("Id"), expectedOuId);

    // Act
    boolean actualResult = store.ouHasChildren(expectedOuId);

    // Assert
    assertTrue(actualResult, "Expected ouHasChildren to be true when account is under OU");
  }

  @Test
  public void ouHasChildren_ouWithChildOu_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> parentOu = store.createOu((String) store.getRoot().get("Id"), "parent");
    String expectedParentOuId = (String) parentOu.get("Id");
    store.createOu(expectedParentOuId, "child");

    // Act
    boolean actualResult = store.ouHasChildren(expectedParentOuId);

    // Assert
    assertTrue(actualResult, "Expected ouHasChildren to be true when child OU exists");
  }

  @Test
  public void ouHasChildren_emptyOu_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "empty-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    boolean actualResult = store.ouHasChildren(expectedOuId);

    // Assert
    assertFalse(actualResult, "Expected ouHasChildren to be false for empty OU");
  }

  @Test
  public void parentExists_forOuId_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    boolean actualResult = store.parentExists(expectedOuId);

    // Assert
    assertTrue(actualResult, "Expected OU to be a valid parent");
  }

  @Test
  public void targetType_forOuId_returnsOrganizationalUnit() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    String actualType = store.targetType(expectedOuId);

    // Assert
    assertEquals(
        "ORGANIZATIONAL_UNIT", actualType, "Expected target type ORGANIZATIONAL_UNIT for OU id");
  }

  @Test
  public void reset_clearsOus() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedOuId = (String) ou.get("Id");

    // Act
    store.reset();

    // Assert
    assertFalse(store.hasOu(expectedOuId), "Expected OUs to be cleared after reset");
  }
}
