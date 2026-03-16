@sdk @session_reset
Feature: Session reset

  Reset clears all runtime state (stored data, fakes, chaos, IAM config)
  without restarting the underlying services.

  @happy
  Scenario: Reset can be called multiple times without error
    Given a running session
    When I reset the session
    And I reset the session again
    Then no error is raised

  @happy
  Scenario: Reset clears DynamoDB table data
    Given a running session with a DynamoDB table "Orders" with partition key "orderId"
    And an item with orderId "order-001" has been put into "Orders"
    When I reset the session
    Then the table "Orders" contains 0 items

  @happy
  Scenario: Reset clears SQS queue messages
    Given a running session with an SQS queue "OrderQueue"
    And a message has been sent to "OrderQueue"
    When I reset the session
    Then "OrderQueue" contains 0 messages
