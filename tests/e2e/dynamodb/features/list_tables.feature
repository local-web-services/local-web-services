@dynamodb @list_tables @controlplane
Feature: DynamoDB ListTables

  @happy
  Scenario: List tables includes a known table
    Given a table "e2e-list-tbl" was created
    When I list tables
    Then the command will succeed
    And the table list will include "e2e-list-tbl"
