@events @list_tags_for_resource @controlplane
Feature: Events ListTagsForResource

  @happy
  Scenario: List tags for an event bus
    Given an event bus "e2e-list-tags-bus" was created
    When I list tags for resource "arn:aws:events:us-east-1:000000000000:event-bus/e2e-list-tags-bus"
    Then the command will succeed
