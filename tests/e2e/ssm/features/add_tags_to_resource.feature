@ssm @add_tags_to_resource @controlplane
Feature: SSM AddTagsToResource

  @happy
  Scenario: Add tags to a parameter
    Given a parameter "/e2e/add-tags-test" was created with value "val1" and type "String"
    When I add tags [{"Key": "env", "Value": "test"}] to parameter "/e2e/add-tags-test"
    Then the command will succeed
