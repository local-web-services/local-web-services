@events @tag_resource @controlplane
Feature: Events TagResource

  @happy
  Scenario: Tag an event bus
    Given an event bus "e2e-tag-bus" was created
    When I tag resource "arn:aws:events:us-east-1:000000000000:event-bus/e2e-tag-bus"
    Then the command will succeed
