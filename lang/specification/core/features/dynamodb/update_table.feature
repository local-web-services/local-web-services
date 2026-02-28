@dynamodb @update_table @controlplane
Feature: DynamoDB UpdateTable

  @happy
  Scenario: Update table billing mode
    Given a table "e2e-update-tbl" was created
    When I update table "e2e-update-tbl" with billing mode "PAY_PER_REQUEST"
    Then the command will succeed
    And table "e2e-update-tbl" will exist
