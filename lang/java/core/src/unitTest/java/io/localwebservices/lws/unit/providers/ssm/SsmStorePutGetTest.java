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
  public void putParameter_createsParam_returnedMapHasNameAndValue() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedName = "myParam";
    String expectedValue = "myValue";

    // Act
    Map<String, Object> actualParam =
        store.putParameter(expectedName, expectedValue, "String", false);

    // Assert
    assertEquals(expectedName, actualParam.get("Name"), "Expected name to match");
    assertEquals(expectedValue, actualParam.get("Value"), "Expected value to match");
  }

  @Test
  public void getParameter_existingParam_returnsMap() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedName = "myParam";
    store.putParameter(expectedName, "myValue", "String", false);

    // Act
    Map<String, Object> actualParam = store.getParameter(expectedName);

    // Assert
    assertNotNull(actualParam, "Expected actualParam to not be null");
    assertEquals(expectedName, actualParam.get("Name"), "Expected name to match");
  }

  @Test
  public void getParameter_missingParam_returnsNull() {
    // Arrange
    SsmStore store = new SsmStore();

    // Act
    Map<String, Object> actualParam = store.getParameter("nonExistent");

    // Assert
    assertNull(actualParam, "Expected actualParam to be null");
  }

  @Test
  public void putParameter_withNullType_defaultsToString() {
    // Arrange
    SsmStore store = new SsmStore();
    String expectedType = "String";

    // Act
    store.putParameter("myParam", "myValue", null, false);
    Map<String, Object> actualParam = store.getParameter("myParam");

    // Assert
    assertEquals(expectedType, actualParam.get("Type"), "Expected type to match");
  }

  @Test
  public void getParameters_mixedNames_returnsFoundAndInvalid() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("a", "val-a", "String", false);
    store.putParameter("b", "val-b", "String", false);
    int expectedFoundSize = 2;
    int expectedInvalidSize = 1;

    // Act
    List<Map<String, Object>> actualFound = store.getParameters(List.of("a", "b", "c"));
    List<String> actualInvalid = store.getInvalidParameters(List.of("a", "b", "c"));

    // Assert
    assertEquals(
        expectedFoundSize,
        actualFound.size(),
        "Expected actualFound.size() to match expectedFoundSize");
    assertEquals(
        expectedInvalidSize,
        actualInvalid.size(),
        "Expected actualInvalid.size() to match expectedInvalidSize");
  }

  @Test
  public void containsParameter_existingParam_returnsTrue() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "myParam";
    store.putParameter(paramName, "myValue", "String", false);

    // Act
    boolean actualResult = store.containsParameter(paramName);

    // Assert
    assertTrue(actualResult, "Expected condition to be true: actualResult");
  }

  @Test
  public void containsParameter_missingParam_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();

    // Act
    boolean actualResult = store.containsParameter("myParam");

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }

  @Test
  public void putParameter_overwriteExisting_incrementsVersion() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "myParam";
    store.putParameter(paramName, "value1", "String", false);
    int expectedVersion = 2;

    // Act
    Map<String, Object> actualParam = store.putParameter(paramName, "value2", "String", true);

    // Assert
    assertEquals(
        expectedVersion,
        ((Number) actualParam.get("Version")).intValue(),
        "Expected version to be incremented on overwrite");
  }

  @Test
  public void putParameter_overwriteNew_versionIsOne() {
    // Arrange
    SsmStore store = new SsmStore();
    int expectedVersion = 1;

    // Act
    Map<String, Object> actualParam = store.putParameter("newParam", "value1", "String", true);

    // Assert
    assertEquals(
        expectedVersion,
        ((Number) actualParam.get("Version")).intValue(),
        "Expected version to be 1 for new parameter even with overwrite=true");
  }

  @Test
  public void reset_clearsAllParameters() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "myParam";
    store.putParameter(paramName, "myValue", "String", false);

    // Act
    store.reset();

    // Assert
    assertFalse(
        store.containsParameter(paramName),
        "Expected condition to be false: store.containsParameter(paramName)");
  }
}
