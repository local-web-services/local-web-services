package io.localwebservices.lws.unit.providers.lambda;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.lambda.LambdaStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class LambdaStoreFunctionTest {

  @Test
  public void functions_put_storesFunctionData() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String expectedFunctionName = "my-fn";

    // Act
    store.functions.put(expectedFunctionName, Map.of("FunctionName", "my-fn", "Runtime", "java17"));

    // Assert
    String actualFunctionName =
        (String) store.functions.get(expectedFunctionName).get("FunctionName");
    assertEquals(expectedFunctionName, actualFunctionName);
  }

  @Test
  public void functions_remove_deletesFunction() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    store.functions.put(functionName, Map.of("FunctionName", functionName));

    // Act
    store.functions.remove(functionName);

    // Assert
    assertNull(store.functions.get(functionName));
  }

  @Test
  public void functions_containsKey_returnsTrue() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";

    // Act
    store.functions.put(functionName, Map.of("FunctionName", functionName));

    // Assert
    assertTrue(store.functions.containsKey(functionName));
  }

  @Test
  public void reset_clearsFunctions() {
    // Arrange
    LambdaStore store = new LambdaStore();
    store.functions.put("my-fn", Map.of("FunctionName", "my-fn"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.functions.isEmpty());
  }

  @Test
  public void functions_values_returnsAllFunctions() {
    // Arrange
    LambdaStore store = new LambdaStore();
    store.functions.put("fn-1", Map.of("FunctionName", "fn-1"));
    store.functions.put("fn-2", Map.of("FunctionName", "fn-2"));

    // Act
    int actualSize = store.functions.values().size();

    // Assert
    int expectedSize = 2;
    assertEquals(expectedSize, actualSize);
  }
}
