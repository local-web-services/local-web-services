@ssm @remove_tags_from_resource @controlplane
Feature: SSM RemoveTagsFromResource

  @happy
  Scenario: Remove tags from a parameter
    Given a parameter "/e2e/remove-tags-test" was created with value "val1" and type "String"
    And tags [{"Key": "env", "Value": "test"}] were added to parameter "/e2e/remove-tags-test"
    When I remove tag keys ["env"] from parameter "/e2e/remove-tags-test"
    Then the command will succeed
