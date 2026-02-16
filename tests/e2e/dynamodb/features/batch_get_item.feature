@dynamodb @batch_get_item @dataplane
Feature: DynamoDB BatchGetItem

  @happy
  Scenario: Batch get items from a table
    Given a table "e2e-batch-get" was created
    And an item was put with key "bg1" and data "hello" into table "e2e-batch-get"
    When I batch get item with key "bg1" from table "e2e-batch-get"
    Then the command will succeed
