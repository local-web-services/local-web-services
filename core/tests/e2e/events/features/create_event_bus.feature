@events @create_event_bus @controlplane
Feature: Events CreateEventBus

  @happy
  Scenario: Create a new event bus
    When I create event bus "e2e-create-bus"
    Then the command will succeed
    And event bus "e2e-create-bus" will appear in list-event-buses
