@lambdaneptune @generated
Feature: LambdaNeptune - The "Lambda" "Function" Executes A Graph Query Against The Available Cluster And Succeeds

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "neptune" "cluster" was "AVAILABLE"
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the operation is rejected

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds fails when the "neptune" "cluster" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "neptune" "cluster" was not "AVAILABLE"
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Then the operation is rejected
