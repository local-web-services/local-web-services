@lambdaneptune @generated
Feature: LambdaNeptune - The "Lambda" "Function" Fails To Connect Because The "Neptune" "Cluster" Is Stopped

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_cluster_stopped
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "neptune" "cluster" was "STOPPED"
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Then the invocation will be "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @guard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @invocation_fails_cluster_stopped @lifecycle
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped fails when the "neptune" "cluster" was not "STOPPED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "neptune" "cluster" was not "STOPPED"
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Then the operation is rejected
