@dynamodb @delete_table @controlplane
Feature: DynamoDB DeleteTable

  @happy
  Scenario: Delete an existing table
    Given a table "e2e-del-tbl" was created
    When I delete table "e2e-del-tbl"
    Then the command will succeed
    And table "e2e-del-tbl" will not appear in list-tables
