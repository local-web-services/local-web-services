@sns @tag_resource @controlplane
Feature: SNS TagResource

  @happy
  Scenario: Tag a topic
    Given a topic "e2e-tag-res" was created
    When I tag resource "e2e-tag-res" with tags '[{"Key":"env","Value":"test"}]'
    Then the command will succeed
