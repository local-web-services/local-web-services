@events @list_event_buses @controlplane
Feature: Events ListEventBuses

  @happy
  Scenario: List event buses includes a created bus
    Given an event bus "e2e-list-bus" was created
    When I list event buses
    Then the command will succeed
    And the output will contain event bus "e2e-list-bus"
