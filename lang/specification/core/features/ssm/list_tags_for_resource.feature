@ssm @list_tags_for_resource @controlplane
Feature: SSM ListTagsForResource

  @happy
  Scenario: List tags for a parameter
    Given a parameter "/e2e/list-tags-test" was created with value "val1" and type "String"
    When I list tags for parameter "/e2e/list-tags-test"
    Then the command will succeed
