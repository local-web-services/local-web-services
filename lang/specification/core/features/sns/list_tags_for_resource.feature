@sns @list_tags_for_resource @controlplane
Feature: SNS ListTagsForResource

  @happy
  Scenario: List tags for a topic
    Given a topic "e2e-list-tags-res" was created
    When I list tags for resource "e2e-list-tags-res"
    Then the command will succeed
