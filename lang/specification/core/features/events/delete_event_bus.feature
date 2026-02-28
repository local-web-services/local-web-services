@events @delete_event_bus @controlplane
Feature: Events DeleteEventBus

  @happy
  Scenario: Delete an existing event bus
    Given an event bus "e2e-del-bus" was created
    When I delete event bus "e2e-del-bus"
    Then the command will succeed
    And event bus "e2e-del-bus" will not appear in list-event-buses
