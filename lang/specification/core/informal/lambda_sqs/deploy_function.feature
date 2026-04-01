@lambdasqs @generated
Feature: LambdaSqs - A "Lambda" "Function" Is Deployed

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a "lambda" "function" is deployed
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is deployed
    Then the "lambda" "function" will be "ACTIVE"
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @deploy_function
  Scenario: a "lambda" "function" is deployed fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "function" is deployed
    Then the operation is rejected
