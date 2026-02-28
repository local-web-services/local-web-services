@dynamodb @transact_get_items @dataplane
Feature: DynamoDB TransactGetItems

  @happy
  Scenario: Transactionally get items from a table
    Given a table "e2e-transact-get" was created
    And an item was put with key "tg1" and data "value" into table "e2e-transact-get"
    When I transact get item with key "tg1" from table "e2e-transact-get"
    Then the command will succeed
