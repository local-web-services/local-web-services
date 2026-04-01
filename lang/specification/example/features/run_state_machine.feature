@stepfunctions @process_order @dataplane
Feature: Process an order through a Step Functions state machine

  @happy @minimal
  Scenario: Process a single order and receive output
    Given an OrderProcessor state machine is running
    When I process order "order-001"
    Then the output will contain order ID "order-001"

  @happy @minimal
  Scenario: Process multiple orders sequentially
    Given an OrderProcessor state machine is running
    When I process orders "order-101", "order-102", "order-103"
    Then each output will contain the corresponding order ID

  @error @guard
  Scenario: Return an error for an unknown state machine ARN
    Given no state machines are configured
    When I process order "order-999" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:DoesNotExist"
    Then an AWS error is returned
