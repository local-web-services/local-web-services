@stepfunctions @mock @dataplane
Feature: Mock Step Functions API calls

  @happy
  Scenario: Return a mocked success response
    Given no state machines are configured
    And StartExecution is mocked to return execution ARN "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:mock-exec"
    And DescribeExecution is mocked to return SUCCEEDED with output containing order ID "order-mock"
    When I process order "order-mock" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then the output will contain order ID "order-mock"

  @error
  Scenario: Propagate an injected AWS error from StartExecution
    Given no state machines are configured
    And StartExecution is mocked to return error "ExecutionLimitExceeded"
    When I process order "order-999" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then an AWS error is returned

  @happy
  Scenario: Apply a response delay to StartExecution
    Given no state machines are configured
    And StartExecution is mocked with a 10ms delay returning execution ARN "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:header-exec"
    And DescribeExecution is mocked to return SUCCEEDED with output containing order ID "order-header"
    When I process order "order-header" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then the output will contain order ID "order-header"
