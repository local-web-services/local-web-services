@sns @untag_resource @controlplane
Feature: SNS UntagResource

  @happy
  Scenario: Untag a topic
    Given a topic "e2e-untag-res" was created
    And tags '[{"Key":"env","Value":"test"}]' were added to topic "e2e-untag-res"
    When I untag resource "e2e-untag-res" with tag keys '["env"]'
    Then the command will succeed
