@stepfunctions @fake @dataplane
Feature: Fake Step Functions API calls

  @happy
  Scenario: Return a faked success response
    Given no state machines are configured
    And StartExecution is faked to return execution ARN "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:fake-exec"
    And DescribeExecution is faked to return SUCCEEDED with output containing order ID "order-fake"
    When I process order "order-fake" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then the output will contain order ID "order-fake"

  @error
  Scenario: Propagate an injected AWS error from StartExecution
    Given no state machines are configured
    And StartExecution is faked to return error "ExecutionLimitExceeded"
    When I process order "order-999" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then an AWS error is returned

  @happy
  Scenario: Apply a response delay to StartExecution
    Given no state machines are configured
    And StartExecution is faked with a 10ms delay returning execution ARN "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:header-exec"
    And DescribeExecution is faked to return SUCCEEDED with output containing order ID "order-header"
    When I process order "order-header" via ARN "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    Then the output will contain order ID "order-header"
