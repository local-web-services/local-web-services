package io.localwebservices.lws.unit.providers.sns;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.providers.sns.SnsStore;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class SnsStoreAttributesTest {

  private SnsStore store;

  @BeforeEach
  void setUp() {
    store = new SnsStore();
    store.reset();
  }

  @Test
  void subscriptionAttrs_putAndGet_roundtrip() {
    // Arrange
    String subArn = "arn:aws:sns:us-east-1:000000000000:my-topic:sub-1";
    Map<String, String> expectedAttrs = Map.of("Endpoint", "http://test");

    // Act
    store.subscriptionAttrs.put(subArn, expectedAttrs);

    // Assert
    var actualAttrs = store.subscriptionAttrs.get(subArn);
    assertEquals(expectedAttrs, actualAttrs);
  }

  @Test
  void resourceTags_putAndGet_roundtrip() {
    // Arrange
    String arn = "arn:aws:sns:us-east-1:000000000000:my-topic";
    List<Map<String, String>> expectedTags = List.of(Map.of("Key", "env", "Value", "prod"));

    // Act
    store.resourceTags.put(arn, expectedTags);

    // Assert
    var actualTags = store.resourceTags.get(arn);
    assertEquals(expectedTags, actualTags);
  }
}
