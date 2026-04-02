@lambdaneptune @generated
Feature: LambdaNeptune - A "Neptune" "Cluster" Is Created

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: a "neptune" "cluster" is created
    Given the "neptune" "cluster" did not already exist
    When a "neptune" "cluster" is created
    Then the "neptune" "cluster" will be "AVAILABLE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @guard @negative @create_cluster
  Scenario: a "neptune" "cluster" is created fails when the "neptune" "cluster" already existed
    Given the "neptune" "cluster" already existed
    When a "neptune" "cluster" is created
    Then the operation is rejected
