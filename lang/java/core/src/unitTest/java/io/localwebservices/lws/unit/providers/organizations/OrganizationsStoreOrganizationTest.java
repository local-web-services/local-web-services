package io.localwebservices.lws.unit.providers.organizations;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.organizations.OrganizationsStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class OrganizationsStoreOrganizationTest {

  @Test
  public void hasOrganization_noOrg_returnsFalse() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    boolean actualResult = store.hasOrganization();

    // Assert
    assertFalse(actualResult, "Expected no organization before creation");
  }

  @Test
  public void createOrganization_newStore_returnsOrgWithId() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    String expectedFeatureSet = "ALL";

    // Act
    Map<String, Object> actualOrg = store.createOrganization(expectedFeatureSet);

    // Assert
    assertNotNull(actualOrg.get("Id"), "Expected org Id to not be null");
    assertEquals(expectedFeatureSet, actualOrg.get("FeatureSet"), "Expected FeatureSet to match");
    String expectedMasterAccountId = "000000000000";
    assertEquals(
        expectedMasterAccountId,
        actualOrg.get("MasterAccountId"),
        "Expected MasterAccountId to match");
  }

  @Test
  public void createOrganization_setsRootNode() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    store.createOrganization("ALL");

    // Assert
    Map<String, Object> actualRoot = store.getRoot();
    assertNotNull(actualRoot, "Expected root to not be null after createOrganization");
    assertEquals("Root", actualRoot.get("Name"), "Expected root name to be Root");
  }

  @Test
  public void hasOrganization_afterCreate_returnsTrue() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");

    // Act
    boolean actualResult = store.hasOrganization();

    // Assert
    assertTrue(actualResult, "Expected hasOrganization to be true after creation");
  }

  @Test
  public void getOrganization_beforeCreate_returnsNull() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    Map<String, Object> actualOrg = store.getOrganization();

    // Assert
    assertNull(actualOrg, "Expected null before organization is created");
  }

  @Test
  public void getRoot_beforeCreate_returnsNull() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    Map<String, Object> actualRoot = store.getRoot();

    // Assert
    assertNull(actualRoot, "Expected null before organization is created");
  }

  @Test
  public void reset_clearsOrganization() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");

    // Act
    store.reset();

    // Assert
    assertFalse(store.hasOrganization(), "Expected hasOrganization to be false after reset");
    assertNull(store.getRoot(), "Expected root to be null after reset");
  }

  @Test
  public void parentExists_beforeOrganizationCreated_returnsFalse() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    boolean actualResult = store.parentExists("any-id");

    // Assert
    assertFalse(actualResult, "Expected false when no organization exists");
  }

  @Test
  public void targetType_beforeOrganizationCreated_returnsNull() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();

    // Act
    String actualType = store.targetType("any-id");

    // Assert
    assertNull(actualType, "Expected null when no organization exists");
  }

  @Test
  public void parentExists_forRootId_returnsTrue() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");
    String expectedRootId = (String) store.getRoot().get("Id");

    // Act
    boolean actualResult = store.parentExists(expectedRootId);

    // Assert
    assertTrue(actualResult, "Expected root to be a valid parent");
  }

  @Test
  public void parentExists_forUnknownId_returnsFalse() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");

    // Act
    boolean actualResult = store.parentExists("unknown-id");

    // Assert
    assertFalse(actualResult, "Expected unknown id to not be a valid parent");
  }

  @Test
  public void targetType_forRootId_returnsRoot() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");
    String expectedRootId = (String) store.getRoot().get("Id");

    // Act
    String actualType = store.targetType(expectedRootId);

    // Assert
    assertEquals("ROOT", actualType, "Expected target type ROOT for root id");
  }

  @Test
  public void targetType_forUnknownId_returnsNull() {
    // Arrange
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");

    // Act
    String actualType = store.targetType("unknown-id");

    // Assert
    assertNull(actualType, "Expected null for unknown target id");
  }
}
