@sdk @dynamodb_helper
Feature: DynamoDB test helper

  @happy
  Scenario: Put an item and assert it exists
    Given a running session with a DynamoDB table "Orders" with partition key "orderId"
    When I put item with orderId "order-helper-001" and status "pending" into "Orders"
    Then the table "Orders" will contain 1 item
    And the table "Orders" will contain an item with orderId "order-helper-001"

  @happy
  Scenario: Item count assertion passes for the correct count
    Given a running session with a DynamoDB table "Orders" with partition key "orderId"
    When I put item with orderId "order-a" and status "pending" into "Orders"
    And I put item with orderId "order-b" and status "pending" into "Orders"
    Then the table "Orders" will contain 2 items

  @happy
  Scenario: Item existence assertion fails when item is absent
    Given a running session with a DynamoDB table "Orders" with partition key "orderId"
    Then the table "Orders" will not contain an item with orderId "order-missing"
