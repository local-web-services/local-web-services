@dynamodb @query @dataplane
Feature: DynamoDB Query

  @happy
  Scenario: Query items by partition key
    Given a table "e2e-query" was created
    And an item was put with key "q1" and data "found" into table "e2e-query"
    When I query table "e2e-query" for key "q1"
    Then the command will succeed
    And the query result will contain at least 1 item
    And the first query result will have data "found"
