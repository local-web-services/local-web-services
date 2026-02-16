@dynamodb @update_item @dataplane
Feature: DynamoDB UpdateItem

  @happy
  Scenario: Update an existing item
    Given a table "e2e-update-item" was created
    And an item was put with key "k1" and data "original" into table "e2e-update-item"
    When I update item with key "k1" setting data to "updated" in table "e2e-update-item"
    Then the command will succeed
    And item with key "k1" in table "e2e-update-item" will have data "updated"
