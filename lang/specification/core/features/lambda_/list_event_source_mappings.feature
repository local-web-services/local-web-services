@lambda @list_event_source_mappings @controlplane
Feature: Lambda ListEventSourceMappings

  @happy
  Scenario: List event source mappings
    When I list event source mappings
    Then the command will succeed
