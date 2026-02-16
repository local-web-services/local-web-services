@events @describe_event_bus @controlplane
Feature: Events DescribeEventBus

  @happy
  Scenario: Describe the default event bus
    When I describe event bus "default"
    Then the command will succeed
