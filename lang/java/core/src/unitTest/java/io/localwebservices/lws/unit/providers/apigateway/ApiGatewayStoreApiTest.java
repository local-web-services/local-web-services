package io.localwebservices.lws.unit.providers.apigateway;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.localwebservices.lws.providers.apigateway.ApiGatewayStore;
import java.util.Map;
import org.junit.jupiter.api.Test;

public class ApiGatewayStoreApiTest {

  @Test
  public void apis_put_storesApiData() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String expectedApiId = "api1";
    String expectedApiName = "MyAPI";

    // Act
    store.apis.put(expectedApiId, Map.of("id", expectedApiId, "name", expectedApiName));

    // Assert
    String actualApiName = (String) store.apis.get(expectedApiId).get("name");
    assertEquals(expectedApiName, actualApiName, "Expected actualApiName to equal expectedApiName");
  }

  @Test
  public void apis_remove_deletesApi() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    String apiId = "api1";
    store.apis.put(apiId, Map.of("id", apiId, "name", "MyAPI"));

    // Act
    store.apis.remove(apiId);

    // Assert
    assertNull(store.apis.get(apiId), "Expected store.apis.get(apiId) to be null");
  }

  @Test
  public void shortId_returnsNonNullTenChars() {
    // Arrange (none required — static utility)

    // Act
    String actualId = ApiGatewayStore.shortId();

    // Assert
    assertNotNull(actualId, "Expected actualId to not be null");
    int expectedLength = 10;
    assertEquals(expectedLength, actualId.length(), "Expected actualId.length() to match expectedLength");
  }

  @Test
  public void shortId_twoCalls_returnsDifferentIds() {
    // Arrange (none required — static utility)

    // Act
    String actualFirstId = ApiGatewayStore.shortId();
    String actualSecondId = ApiGatewayStore.shortId();

    // Assert
    assertNotEquals(actualFirstId, actualSecondId, "Expected actualFirstId and actualSecondId to differ");
  }

  @Test
  public void reset_clearsApis() {
    // Arrange
    ApiGatewayStore store = new ApiGatewayStore();
    store.apis.put("api1", Map.of("id", "api1", "name", "MyAPI"));

    // Act
    store.reset();

    // Assert
    assertTrue(store.apis.isEmpty(), "Expected store.apis to be empty");
  }
}
