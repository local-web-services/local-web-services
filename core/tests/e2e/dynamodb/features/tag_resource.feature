@dynamodb @tag_resource @controlplane
Feature: DynamoDB TagResource

  @happy
  Scenario: Tag a DynamoDB table
    Given a table "e2e-ddb-tag" was created
    When I tag table "e2e-ddb-tag" with key "env" and value "test"
    Then the command will succeed
