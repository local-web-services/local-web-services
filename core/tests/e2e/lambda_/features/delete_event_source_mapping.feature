@lambda @delete_event_source_mapping @controlplane
Feature: Lambda DeleteEventSourceMapping

  @happy
  Scenario: Delete an event source mapping
    Given an event source mapping was created for function "e2e-del-esm-fn" with source "arn:aws:sqs:us-east-1:000000000000:e2e-del-esm-queue"
    When I delete the event source mapping
    Then the command will succeed
    And the event source mapping will not appear in the list
