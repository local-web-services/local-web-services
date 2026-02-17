@lambda @get_event_source_mapping @controlplane @requires_docker
Feature: Lambda GetEventSourceMapping

  @happy
  Scenario: Get an event source mapping by UUID
    Given a function "e2e-getesm-fn" was created with runtime "python3.12" and handler "handler.handler"
    And an event source mapping was created for function "e2e-getesm-fn" with source "arn:aws:sqs:us-east-1:000000000000:e2e-getesm-q"
    When I get the event source mapping
    Then the command will succeed
    And the output will contain a UUID
