package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SsmStorePathTest {

  @Test
  public void getParametersByPath_matchingPrefix_returnsTwoParams() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/app/db", "val1", "String", false);
    store.putParameter("/app/svc", "val2", "String", false);
    store.putParameter("/other/x", "val3", "String", false);
    int expectedSize = 2;

    // Act
    List<Map<String, Object>> actualParams = store.getParametersByPath("/app");

    // Assert
    assertEquals(
        expectedSize, actualParams.size(), "Expected actualParams.size() to match expectedSize");
  }

  @Test
  public void getParametersByPath_noMatch_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/x/y", "val", "String", false);

    // Act
    List<Map<String, Object>> actualParams = store.getParametersByPath("/z");

    // Assert
    assertTrue(actualParams.isEmpty(), "Expected actualParams to be empty");
  }

  @Test
  public void deleteParameter_existingParam_removesIt() {
    // Arrange
    SsmStore store = new SsmStore();
    String paramName = "p";
    store.putParameter(paramName, "v", "String", false);

    // Act
    boolean actualDeleteResult = store.deleteParameter(paramName);

    // Assert
    assertTrue(actualDeleteResult, "Expected condition to be true: actualDeleteResult");
    assertFalse(
        store.containsParameter(paramName),
        "Expected condition to be false: store.containsParameter(paramName)");
  }

  @Test
  public void deleteParameter_missingParam_returnsFalse() {
    // Arrange
    SsmStore store = new SsmStore();

    // Act
    boolean actualResult = store.deleteParameter("missing");

    // Assert
    assertFalse(actualResult, "Expected condition to be false: actualResult");
  }
}
