@dynamodb @untag_resource @controlplane
Feature: DynamoDB UntagResource

  @happy
  Scenario: Untag a DynamoDB table
    Given a table "e2e-ddb-untag" was created
    And table "e2e-ddb-untag" was tagged with key "env" and value "test"
    When I untag table "e2e-ddb-untag" removing key "env"
    Then the command will succeed
