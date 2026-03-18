package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SsmStorePutGetTest {

  @Test
  public void putParameter_createsNewParameter_returnsParamMap() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedName = "/my/param";
    String expectedValue = "hello";
    String expectedType = "String";

    // Act
    Map<String, Object> actualParam = store.putParameter(expectedName, expectedValue, expectedType, false);

    // Assert
    assertEquals(expectedName, actualParam.get("Name"));
    assertEquals(expectedValue, actualParam.get("Value"));
    assertEquals(expectedType, actualParam.get("Type"));
    assertNotNull(actualParam.get("Version"));
  }

  @Test
  public void getParameter_existingParam_returnsMap() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedName = "/get/param";
    String expectedValue = "world";
    String expectedType = "SecureString";
    store.putParameter(expectedName, expectedValue, expectedType, false);

    // Act
    Map<String, Object> actualParam = store.getParameter(expectedName);

    // Assert
    assertNotNull(actualParam);
    assertEquals(expectedName, actualParam.get("Name"));
    assertEquals(expectedValue, actualParam.get("Value"));
    assertEquals(expectedType, actualParam.get("Type"));
  }

  @Test
  public void getParameter_missingParam_returnsNull() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/does/not/exist";

    // Act
    Map<String, Object> actualParam = store.getParameter(paramName);

    // Assert
    assertNull(actualParam);
  }

  @Test
  public void putParameter_withNullType_defaultsToString() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedType = "String";

    // Act
    Map<String, Object> actualParam = store.putParameter("/typed/param", "value", null, false);

    // Assert
    assertEquals(expectedType, actualParam.get("Type"));
  }

  @Test
  public void getParameters_mixedNames_returnsSplitLists() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/a", "val-a", "String", false);
    store.putParameter("/b", "val-b", "String", false);
    int expectedFoundCount = 2;
    int expectedInvalidCount = 1;
    String expectedMissingName = "/c";

    // Act
    List<Map<String, Object>> actualFound = store.getParameters(List.of("/a", "/b", "/c"));
    List<String> actualInvalid = store.getInvalidParameters(List.of("/a", "/b", "/c"));

    // Assert
    assertEquals(expectedFoundCount, actualFound.size());
    assertEquals(expectedInvalidCount, actualInvalid.size());
    assertEquals(expectedMissingName, actualInvalid.get(0));
  }

  @Test
  public void containsParameter_existingParam_returnsTrue() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/exists/param";
    store.putParameter(paramName, "v", "String", false);

    // Act
    boolean actualResult = store.containsParameter(paramName);

    // Assert
    assertTrue(actualResult);
  }

  @Test
  public void containsParameter_missingParam_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/missing/param";

    // Act
    boolean actualResult = store.containsParameter(paramName);

    // Assert
    assertFalse(actualResult);
  }

  @Test
  public void reset_clearsAllParameters() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "/reset/param";
    store.putParameter(paramName, "v", "String", false);

    // Act
    store.reset();

    // Assert
    assertFalse(store.containsParameter(paramName));
  }
}
