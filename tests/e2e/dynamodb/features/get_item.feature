@dynamodb @get_item @dataplane
Feature: DynamoDB GetItem

  @happy
  Scenario: Get an existing item
    Given a table "e2e-get-item" was created
    And an item was put with key "k1" and data "found" into table "e2e-get-item"
    When I get item with key "k1" from table "e2e-get-item"
    Then the command will succeed
    And the output will contain item data "found"
