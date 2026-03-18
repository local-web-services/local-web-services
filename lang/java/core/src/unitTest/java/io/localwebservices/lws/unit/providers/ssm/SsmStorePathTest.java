package io.localwebservices.lws.unit.providers.ssm;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.ssm.SsmStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class SsmStorePathTest {

  @Test
  public void getParametersByPath_matchingPrefix_returnsMatchingParams() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/app/config/db", "localhost", "String", false);
    store.putParameter("/app/config/port", "5432", "String", false);
    store.putParameter("/other/key", "irrelevant", "String", false);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualParams = store.getParametersByPath("/app/config");

    // Assert
    assertEquals(expectedCount, actualParams.size());
  }

  @Test
  public void getParametersByPath_noMatch_returnsEmptyList() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/app/config/db", "localhost", "String", false);
    int expectedCount = 0;

    // Act
    List<Map<String, Object>> actualParams = store.getParametersByPath("/nonexistent/path");

    // Assert
    assertEquals(expectedCount, actualParams.size());
  }

  @Test
  public void getParametersByPath_rootPath_returnsAllUnderRoot() {
    // Arrange
    SsmStore store = new SsmStore();
    store.putParameter("/app/a", "val-a", "String", false);
    store.putParameter("/app/b", "val-b", "String", false);
    int expectedCount = 2;

    // Act
    List<Map<String, Object>> actualParams = store.getParametersByPath("/app");

    // Assert
    assertEquals(expectedCount, actualParams.size());
    List<Object> actualNames = actualParams.stream().map(p -> p.get("Name")).toList();
    assertTrue(actualNames.contains("/app/a"));
    assertTrue(actualNames.contains("/app/b"));
  }
}
