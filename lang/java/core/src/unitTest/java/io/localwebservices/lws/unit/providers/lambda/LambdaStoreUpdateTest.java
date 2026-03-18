package io.localwebservices.lws.unit.providers.lambda;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.localwebservices.lws.providers.lambda.LambdaStore;
import java.util.HashMap;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class LambdaStoreUpdateTest {

  @Test
  public void functions_updateCodeHash_updatesField() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    Map<String, Object> functionData = new HashMap<>();
    functionData.put("FunctionName", functionName);
    store.functions.put(functionName, functionData);
    String expectedCodeSha = "abc123";

    // Act
    store.functions.get(functionName).put("CodeSha256", expectedCodeSha);

    // Assert
    String actualCodeSha = (String) store.functions.get(functionName).get("CodeSha256");
    assertEquals(expectedCodeSha, actualCodeSha);
  }

  @Test
  public void functions_updateConfiguration_updatesRuntime() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    Map<String, Object> functionData = new HashMap<>();
    functionData.put("FunctionName", functionName);
    functionData.put("Runtime", "java17");
    store.functions.put(functionName, functionData);
    String expectedRuntime = "java21";

    // Act
    store.functions.get(functionName).put("Runtime", expectedRuntime);

    // Assert
    String actualRuntime = (String) store.functions.get(functionName).get("Runtime");
    assertEquals(expectedRuntime, actualRuntime);
  }

  @Test
  public void functions_put_overwritesExisting() {
    // Arrange
    LambdaStore store = new LambdaStore();
    String functionName = "my-fn";
    store.functions.put(functionName, Map.of("FunctionName", functionName, "Runtime", "java17"));
    String expectedRuntime = "python3.11";

    // Act
    store.functions.put(
        functionName, Map.of("FunctionName", functionName, "Runtime", expectedRuntime));

    // Assert
    String actualRuntime = (String) store.functions.get(functionName).get("Runtime");
    assertEquals(expectedRuntime, actualRuntime);
  }
}
