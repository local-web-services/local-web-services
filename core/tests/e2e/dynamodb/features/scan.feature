@dynamodb @scan @dataplane
Feature: DynamoDB Scan

  @happy
  Scenario: Scan returns all items in a table
    Given a table "e2e-scan" was created
    And an item was put with key "s1" and data "a" into table "e2e-scan"
    And an item was put with key "s2" and data "b" into table "e2e-scan"
    When I scan table "e2e-scan"
    Then the command will succeed
    And the scan result will contain at least 2 items
    And the scan result will include key "s1"
    And the scan result will include key "s2"
