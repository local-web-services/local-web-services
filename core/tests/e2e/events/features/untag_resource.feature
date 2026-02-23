@events @untag_resource @controlplane
Feature: Events UntagResource

  @happy
  Scenario: Untag an event bus
    Given an event bus "e2e-untag-bus" was created
    And resource "arn:aws:events:us-east-1:000000000000:event-bus/e2e-untag-bus" was tagged
    When I untag resource "arn:aws:events:us-east-1:000000000000:event-bus/e2e-untag-bus"
    Then the command will succeed
    And event bus "e2e-untag-bus" will not have tag "env"
