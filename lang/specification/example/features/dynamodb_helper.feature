@dynamodb @dynamodb_helper @dataplane
Feature: DynamoDB helper seeds and asserts test data

  @happy @minimal
  Scenario: Seed an item and assert it exists
    Given a DynamoDB table "Orders" with partition key "orderId"
    When I put item with orderId "order-helper-001" and status "pending" into "Orders"
    Then the table "Orders" will contain 1 item
    And the table "Orders" will contain an item with orderId "order-helper-001"
