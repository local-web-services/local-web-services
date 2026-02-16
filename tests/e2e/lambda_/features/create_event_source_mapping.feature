@lambda @create_event_source_mapping @controlplane
Feature: Lambda CreateEventSourceMapping

  @happy
  Scenario: Create an event source mapping and verify it appears in list
    When I create event source mapping for function "e2e-esm-function" with source "arn:aws:sqs:us-east-1:000000000000:e2e-esm-queue" and batch size "5"
    Then the command will succeed
    And the output will contain a UUID
    And the event source mapping will appear in the list
