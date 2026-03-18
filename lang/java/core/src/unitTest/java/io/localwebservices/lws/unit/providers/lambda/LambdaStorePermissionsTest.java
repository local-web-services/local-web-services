package io.localwebservices.lws.unit.providers.lambda;

import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.lambda.LambdaStore;
import java.util.ArrayList;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class LambdaStorePermissionsTest {

  @Test
  public void permissions_computeIfAbsent_createsEmptyList() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    String expectedStatementId = "s1";

    // Act
    store
        .permissions
        .computeIfAbsent(functionName, k -> new ArrayList<>())
        .add(Map.of("StatementId", expectedStatementId));

    // Assert
    int actualSize = store.permissions.get(functionName).size();
    int expectedSize = 1;
    assertTrue(actualSize == expectedSize);
  }

  @Test
  public void permissions_remove_deletesPermissions() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    store
        .permissions
        .computeIfAbsent(functionName, k -> new ArrayList<>())
        .add(Map.of("StatementId", "s1"));

    // Act
    store.permissions.remove(functionName);

    // Assert
    assertNull(store.permissions.get(functionName));
  }

  @Test
  public void reset_clearsPermissions() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    store
        .permissions
        .computeIfAbsent(functionName, k -> new ArrayList<>())
        .add(Map.of("StatementId", "s1"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.permissions.isEmpty());
  }
}
