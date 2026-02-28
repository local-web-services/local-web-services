@dynamodb @transact_write_items @dataplane
Feature: DynamoDB TransactWriteItems

  @happy
  Scenario: Condition check passes and allows writes
    Given a table "e2e-transact-cc-pass" was created
    And an item was put with key "guard" and status "ok" into table "e2e-transact-cc-pass"
    When I transact write with condition check on key "guard" and put key "new-item" with data "written" in table "e2e-transact-cc-pass"
    Then the command will succeed
    And item with key "new-item" in table "e2e-transact-cc-pass" will have data "written"

  @happy
  Scenario: Condition check fails and blocks writes
    Given a table "e2e-transact-cc-fail" was created
    When I transact write with condition check on key "nonexistent" and put key "blocked" with data "nope" in table "e2e-transact-cc-fail"
    Then the command will succeed
    And the output will contain a TransactionCanceledException
    And item with key "blocked" will not exist in table "e2e-transact-cc-fail"
