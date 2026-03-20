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
    assertTrue(actualResult, "Expected condition to be true: actualResult");
    assertFalse(store.containsParameter(paramName), "Expected condition to be false: store.containsParameter(paramName)");
  }

  @Test
  public void deleteParameter_missingParam_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/does/not/exist";

    // Act
    boolean actualResult = store.deleteParameter(paramName);

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
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
    assertEquals(expectedDeletedCount, actualDeleted.size(), "Expected actualDeleted.size() to match expectedDeletedCount");
    assertTrue(actualDeleted.contains("/del/a"), "Expected value to contain expected substring");
    assertTrue(actualDeleted.contains("/del/b"), "Expected value to contain expected substring");
    assertEquals(expectedMissingCount, store.getParameters(List.of("/del/a", "/del/b")).size(), "Expected store.getParameters(List.of("/del/a", "/del/b")).size() to match expectedMissingCount");
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
    assertEquals(expectedCount, actualParams.size(), "Expected actualParams.size() to match expectedCount");
    assertEquals(expectedName, actualParams.get(0).get("Name"), "Expected actualParams.get(0).get("Name") to equal expectedName");
    assertEquals(expectedType, actualParams.get(0).get("Type"), "Expected actualParams.get(0).get("Type") to equal expectedType");
  }

  @Test
  public void describeParameters_emptyStore_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualParams = store.describeParameters();

    // Assert
    assertEquals(expectedCount, actualParams.size(), "Expected actualParams.size() to match expectedCount");
  }
}
