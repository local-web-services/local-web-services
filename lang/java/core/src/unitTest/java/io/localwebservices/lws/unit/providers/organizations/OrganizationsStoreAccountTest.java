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

public class OrganizationsStoreAccountTest {

  private OrganizationsStore storeWithOrg() {
    OrganizationsStore store = new OrganizationsStore();
    store.createOrganization("ALL");
    return store;
  }

  @Test
  public void createAccount_newAccount_returnsAccountWithId() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedName = "test-account";
    String expectedEmail = "test@example.com";

    // Act
    Map<String, Object> actualAccount = store.createAccount(expectedName, expectedEmail);

    // Assert
    assertNotNull(actualAccount.get("Id"), "Expected account Id to not be null");
    assertEquals(expectedName, actualAccount.get("Name"), "Expected Name to match");
    assertEquals(expectedEmail, actualAccount.get("Email"), "Expected Email to match");
    assertEquals("ACTIVE", actualAccount.get("Status"), "Expected Status to be ACTIVE");
  }

  @Test
  public void hasAccount_afterCreate_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> account = store.createAccount("test", "test@example.com");
    String expectedId = (String) account.get("Id");

    // Act
    boolean actualResult = store.hasAccount(expectedId);

    // Assert
    assertTrue(actualResult, "Expected hasAccount to be true after creation");
  }

  @Test
  public void hasAccount_missingId_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    boolean actualResult = store.hasAccount("nonexistent");

    // Assert
    assertFalse(actualResult, "Expected hasAccount to be false for missing id");
  }

  @Test
  public void getAccount_existingId_returnsAccount() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> expected = store.createAccount("test", "test@example.com");
    String expectedId = (String) expected.get("Id");

    // Act
    Map<String, Object> actualAccount = store.getAccount(expectedId);

    // Assert
    assertNotNull(actualAccount, "Expected account to not be null");
    assertEquals(expectedId, actualAccount.get("Id"), "Expected Id to match");
  }

  @Test
  public void getAccount_missingId_returnsNull() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    Map<String, Object> actualAccount = store.getAccount("nonexistent");

    // Assert
    assertNull(actualAccount, "Expected null for missing account");
  }

  @Test
  public void getAllAccounts_multipleAccounts_returnsAll() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createAccount("a", "a@example.com");
    store.createAccount("b", "b@example.com");
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualAccounts = store.getAllAccounts();

    // Assert
    assertEquals(expectedSize, actualAccounts.size(), "Expected getAllAccounts size to match");
  }

  @Test
  public void emailInUse_accountExistsButDifferentEmail_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createAccount("test", "taken@example.com");

    // Act
    boolean actualResult = store.emailInUse("other@example.com");

    // Assert
    assertFalse(actualResult, "Expected emailInUse to be false when email differs");
  }

  @Test
  public void getAccountsForParent_accountUnderDifferentParent_returnsEmpty() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    store.createAccount("a", "a@example.com");
    String expectedOuId = (String) ou.get("Id");
    int expectedSize = 0;

    // Act
    List<Object> actualAccounts = store.getAccountsForParent(expectedOuId);

    // Assert
    assertEquals(
        expectedSize,
        actualAccounts.size(),
        "Expected no accounts when none are under this parent");
  }

  @Test
  public void emailInUse_existingEmail_returnsTrue() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    String expectedEmail = "used@example.com";
    store.createAccount("test", expectedEmail);

    // Act
    boolean actualResult = store.emailInUse(expectedEmail);

    // Assert
    assertTrue(actualResult, "Expected emailInUse to be true for existing email");
  }

  @Test
  public void emailInUse_newEmail_returnsFalse() {
    // Arrange
    OrganizationsStore store = storeWithOrg();

    // Act
    boolean actualResult = store.emailInUse("new@example.com");

    // Assert
    assertFalse(actualResult, "Expected emailInUse to be false for unused email");
  }

  @Test
  public void getAccountsForParent_rootParent_returnsAccounts() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createAccount("a", "a@example.com");
    String expectedRootId = (String) store.getRoot().get("Id");
    int expectedSize = 1;

    // Act
    List<Object> actualAccounts = store.getAccountsForParent(expectedRootId);

    // Assert
    assertEquals(expectedSize, actualAccounts.size(), "Expected one account under root");
  }

  @Test
  public void getAccountParent_afterCreate_returnsRootId() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> account = store.createAccount("a", "a@example.com");
    String expectedParentId = (String) store.getRoot().get("Id");
    String expectedAccountId = (String) account.get("Id");

    // Act
    String actualParentId = store.getAccountParent(expectedAccountId);

    // Assert
    assertEquals(expectedParentId, actualParentId, "Expected parent to be root after creation");
  }

  @Test
  public void moveAccount_changesParent() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> account = store.createAccount("a", "a@example.com");
    String expectedAccountId = (String) account.get("Id");
    Map<String, Object> ou = store.createOu((String) store.getRoot().get("Id"), "test-ou");
    String expectedNewParentId = (String) ou.get("Id");

    // Act
    store.moveAccount(expectedAccountId, expectedNewParentId);

    // Assert
    String actualParentId = store.getAccountParent(expectedAccountId);
    assertEquals(expectedNewParentId, actualParentId, "Expected parent to be OU after move");
  }

  @Test
  public void reset_clearsAccounts() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    store.createAccount("a", "a@example.com");

    // Act
    store.reset();

    // Assert
    assertEquals(0, store.getAllAccounts().size(), "Expected no accounts after reset");
  }

  @Test
  public void targetType_forAccountId_returnsAccount() {
    // Arrange
    OrganizationsStore store = storeWithOrg();
    Map<String, Object> account = store.createAccount("a", "a@example.com");
    String expectedAccountId = (String) account.get("Id");

    // Act
    String actualType = store.targetType(expectedAccountId);

    // Assert
    assertEquals("ACCOUNT", actualType, "Expected target type ACCOUNT for account id");
  }
}
