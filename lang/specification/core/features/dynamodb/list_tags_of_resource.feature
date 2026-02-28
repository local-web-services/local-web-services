@dynamodb @list_tags_of_resource @controlplane
Feature: DynamoDB ListTagsOfResource

  @happy
  Scenario: List tags for a DynamoDB table
    Given a table "e2e-ddb-listtags" was created
    And table "e2e-ddb-listtags" was tagged with key "env" and value "prod"
    When I list tags of table "e2e-ddb-listtags"
    Then the command will succeed
