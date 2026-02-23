@dynamodb @put_item @dataplane
Feature: DynamoDB PutItem

  @happy
  Scenario: Put an item into a table
    Given a table "e2e-put-item" was created
    When I put an item with key "k1" and data "hello" into table "e2e-put-item"
    Then the command will succeed
    And item with key "k1" in table "e2e-put-item" will have data "hello"
