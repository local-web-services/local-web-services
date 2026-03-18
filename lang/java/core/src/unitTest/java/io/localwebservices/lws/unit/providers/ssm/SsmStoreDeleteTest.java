package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SsmStoreDeleteTest {

  @Test
  public void deleteParameter_existingParam_returnsTrue() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/delete/me";
    store.putParameter(paramName, "v", "String", false);

    // Act
    boolean actualResult = store.deleteParameter(paramName);

    // Assert
    assertTrue(actualResult);
    assertFalse(store.containsParameter(paramName));
  }

  @Test
  public void deleteParameter_missingParam_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/does/not/exist";

    // Act
    boolean actualResult = store.deleteParameter(paramName);

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void deleteParameters_mixedNames_returnsDeletedNames() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/del/a", "v", "String", false);
    store.putParameter("/del/b", "v", "String", false);
    int expectedDeletedCount = 2;
    int expectedMissingCount = 0;

    // Act
    List<String> actualDeleted = store.deleteParameters(List.of("/del/a", "/del/b", "/del/c"));

    // Assert
    assertEquals(expectedDeletedCount, actualDeleted.size());
    assertTrue(actualDeleted.contains("/del/a"));
    assertTrue(actualDeleted.contains("/del/b"));
    assertEquals(expectedMissingCount, store.getParameters(List.of("/del/a", "/del/b")).size());
  }

  @Test
  public void describeParameters_returnsNameAndType() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/desc/param", "v", "SecureString", false);
    String expectedName = "/desc/param";
    String expectedType = "SecureString";
    int expectedCount = 1;

    // Act
    List<Map<String, Object>> actualParams = store.describeParameters();

    // Assert
    assertEquals(expectedCount, actualParams.size());
    assertEquals(expectedName, actualParams.get(0).get("Name"));
    assertEquals(expectedType, actualParams.get(0).get("Type"));
  }

  @Test
  public void describeParameters_emptyStore_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualParams = store.describeParameters();

    // Assert
    assertEquals(expectedCount, actualParams.size());
  }
}
