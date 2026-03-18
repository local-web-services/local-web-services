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
    assertEquals(expectedVaultName, actualVault.get("VaultName"));
    assertNotNull(actualVault.get("VaultARN"));
    assertTrue(actualVault.get("VaultARN").toString().contains("my-vault"));
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
    assertNotNull(actualVault);
    assertEquals(expectedVaultName, actualVault.get("VaultName"));
  }

  @Test
  public void getVault_nonExistentName_returnsNull() {
    // Arrange
    GlacierStore store = new GlacierStore();
    String vaultName = "unknown-vault";

    // Act
    Map<String, Object> actualVault = store.getVault(vaultName);

    // Assert
    assertNull(actualVault);
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
    assertEquals(expectedSize, actualVaults.size());
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
    assertNull(store.getVault(vaultName));
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
    assertEquals(expectedSize, actualVaults.size());
  }
}
