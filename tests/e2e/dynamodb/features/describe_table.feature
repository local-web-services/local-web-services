@dynamodb @describe_table @controlplane
Feature: DynamoDB DescribeTable

  @happy
  Scenario: Describe an existing table
    Given a table "e2e-desc-tbl" was created
    When I describe table "e2e-desc-tbl"
    Then the command will succeed
    And the output will contain table name "e2e-desc-tbl"
