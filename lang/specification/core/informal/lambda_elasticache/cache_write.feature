@lambdaelasticache @generated
Feature: LambdaElasticache - The "Lambda" "Function" Writes A Value To The "Elasticache" "Cluster" During Invocation

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @cache_write
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And an "elasticache" "key" "slot" was "available"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the "elasticache" "cache" "entry" will be "CACHED" in the "elasticache" "cluster"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"

  @guard @negative @cache_write @lifecycle
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when the "elasticache" "cluster" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" did not exist
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write @lifecycle
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write @capacity
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when no "elasticache" "key" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And no "elasticache" "key" "slot" was "available"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected
