package io.localwebservices.lws;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class CapacityConfigTest {

  @Test
  void isExhausted_returnsFalseWhenSlotsIsNull() {
    // Arrange
    ServerState.CapacityConfig expectedConfig = new ServerState.CapacityConfig();
    Integer expectedSlots = null;
    expectedConfig.setSlots(expectedSlots);

    // Act
    boolean actualExhausted = expectedConfig.isExhausted();

    // Assert
    assertFalse(actualExhausted, "null slots should not be exhausted");
  }

  @Test
  void isExhausted_returnsTrueWhenSlotsIsZero() {
    // Arrange
    ServerState.CapacityConfig expectedConfig = new ServerState.CapacityConfig();
    int expectedSlots = 0;
    expectedConfig.setSlots(expectedSlots);

    // Act
    boolean actualExhausted = expectedConfig.isExhausted();

    // Assert
    assertTrue(actualExhausted, "slots=0 should be exhausted");
  }

  @Test
  void isExhausted_returnsFalseWhenSlotsIsPositive() {
    // Arrange
    ServerState.CapacityConfig expectedConfig = new ServerState.CapacityConfig();
    int expectedSlots = 5;
    expectedConfig.setSlots(expectedSlots);

    // Act
    boolean actualExhausted = expectedConfig.isExhausted();

    // Assert
    assertFalse(actualExhausted, "positive slots should not be exhausted");
  }

  @Test
  void reset_clearsSlotsToNull() {
    // Arrange
    ServerState.CapacityConfig expectedConfig = new ServerState.CapacityConfig();
    expectedConfig.setSlots(0);

    // Act
    expectedConfig.reset();
    Integer actualSlots = expectedConfig.getSlots();

    // Assert
    assertNull(actualSlots, "reset should set slots to null");
  }

  @Test
  void getSlots_returnsSetValue() {
    // Arrange
    ServerState.CapacityConfig expectedConfig = new ServerState.CapacityConfig();
    int expectedSlots = 10;

    // Act
    expectedConfig.setSlots(expectedSlots);
    Integer actualSlots = expectedConfig.getSlots();

    // Assert
    assertEquals(expectedSlots, actualSlots);
  }

  @Test
  void serverState_getCapacityConfig_returnsSameInstanceForSameService() {
    // Arrange
    ServerState expectedState = new ServerState();
    String expectedService = "dynamodb";

    // Act
    ServerState.CapacityConfig actualFirst = expectedState.getCapacityConfig(expectedService);
    ServerState.CapacityConfig actualSecond = expectedState.getCapacityConfig(expectedService);

    // Assert
    assertSame(actualFirst, actualSecond, "same instance should be returned for the same service");
  }

  @Test
  void serverState_resetAllCapacity_setsAllSlotsToNull() {
    // Arrange
    ServerState expectedState = new ServerState();
    expectedState.getCapacityConfig("dynamodb").setSlots(0);
    expectedState.getCapacityConfig("stepfunctions").setSlots(0);

    // Act
    expectedState.resetAllCapacity();

    // Assert
    assertNull(expectedState.getCapacityConfig("dynamodb").getSlots());
    assertNull(expectedState.getCapacityConfig("stepfunctions").getSlots());
  }

  @Test
  void serverState_reset_clearsCapacityConfigs() {
    // Arrange
    ServerState expectedState = new ServerState();
    expectedState.getCapacityConfig("dynamodb").setSlots(0);

    // Act
    expectedState.reset();
    boolean actualExhausted = expectedState.getCapacityConfig("dynamodb").isExhausted();

    // Assert
    assertFalse(actualExhausted, "reset() should clear all capacity configs");
  }
}
