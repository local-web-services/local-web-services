@lambdasqs @generated
Feature: LambdaSqs - The Event Source Mapping Polls The Queue And Invokes The Lambda Function

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And an "AVAILABLE" message exists in the mapped queue
    And an invocation slot is available
    When the event source mapping polls the queue and invokes the Lambda function
    Then the message is "IN_FLIGHT" and a Lambda invocation is "IN_PROGRESS"
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @standard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function fails when the event source mapping does not exist
    Given the event source mapping does not exist
    When the event source mapping polls the queue and invokes the Lambda function
    Then the operation is rejected

  @standard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function fails when the event source mapping is not "ENABLED"
    Given the event source mapping exists
    And the event source mapping is not "ENABLED"
    When the event source mapping polls the queue and invokes the Lambda function
    Then the operation is rejected

  @standard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function fails when the mapped function is not "ACTIVE"
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is not "ACTIVE"
    When the event source mapping polls the queue and invokes the Lambda function
    Then the operation is rejected

  @standard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function fails when no "AVAILABLE" message exists in the mapped queue
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And no "AVAILABLE" message exists in the mapped queue
    When the event source mapping polls the queue and invokes the Lambda function
    Then the operation is rejected

  @standard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the Lambda function fails when no invocation slot is available
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And an "AVAILABLE" message exists in the mapped queue
    And no invocation slot is available
    When the event source mapping polls the queue and invokes the Lambda function
    Then the operation is rejected
