package io.localwebservices.lws.unit.providers.glacier;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.glacier.GlacierStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class GlacierStoreVaultTest {

  @Test
  public void createVault_newName_storesVaultWithArn() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "my-vault";
    String expectedVaultName = "my-vault";

    // Act
    Map<String, Object> actualVault = store.createVault(vaultName);

    // Assert
    assertEquals(expectedVaultName, actualVault.get("VaultName"), "Expected vaultName to match");
    assertNotNull(actualVault.get("VaultARN"), "Expected values to match");
    assertTrue(
        actualVault.get("VaultARN").toString().contains("my-vault"),
        "Expected value to contain expected substring");
  }

  @Test
  public void getVault_existingName_returnsVault() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "existing-vault";
    String expectedVaultName = "existing-vault";
    store.createVault(vaultName);

    // Act
    Map<String, Object> actualVault = store.getVault(vaultName);

    // Assert
    assertNotNull(actualVault, "Expected actualVault to not be null");
    assertEquals(expectedVaultName, actualVault.get("VaultName"), "Expected vaultName to match");
  }

  @Test
  public void getVault_nonExistentName_returnsNull() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "unknown-vault";

    // Act
    Map<String, Object> actualVault = store.getVault(vaultName);

    // Assert
    assertNull(actualVault, "Expected actualVault to be null");
  }

  @Test
  public void listVaults_twoVaults_returnsBoth() {
    // Arrange
    GlacierStore store = new GlacierStore();
    store.createVault("vault-one");
    store.createVault("vault-two");
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualVaults = store.listVaults();

    // Assert
    assertEquals(
        expectedSize, actualVaults.size(), "Expected actualVaults.size() to match expectedSize");
  }

  @Test
  public void deleteVault_removesVault() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "vault-to-delete";
    store.createVault(vaultName);

    // Act
    store.deleteVault(vaultName);

    // Assert
    assertNull(store.getVault(vaultName), "Expected store.getVault(vaultName) to be null");
  }

  @Test
  public void reset_clearsAllVaults() {
    // Arrange
    GlacierStore store = new GlacierStore();
    store.createVault("vault-a");
    int expectedSize = 0;

    // Act
    store.reset();

    // Assert
    List<Map<String, Object>> actualVaults = store.listVaults();
    assertEquals(
        expectedSize, actualVaults.size(), "Expected actualVaults.size() to match expectedSize");
  }
}
