@dynamodb @delete_item @dataplane
Feature: DynamoDB DeleteItem

  @happy
  Scenario: Delete an existing item
    Given a table "e2e-del-item" was created
    And an item was put with key "k1" into table "e2e-del-item"
    When I delete item with key "k1" from table "e2e-del-item"
    Then the command will succeed
    And table "e2e-del-item" will have 0 items
