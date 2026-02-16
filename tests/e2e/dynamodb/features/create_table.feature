@dynamodb @create_table @controlplane
Feature: DynamoDB CreateTable

  @happy
  Scenario: Create a new table
    When I create a table "e2e-create-tbl"
    Then the command will succeed
    And the output will contain table name "e2e-create-tbl"
    And table "e2e-create-tbl" will exist
