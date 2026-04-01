@lambdamemorydb @generated
Feature: LambdaMemorydb - The "Lambda" "Function" Writes A Record To The Available Memorydb Cluster During Invocation

  # Generated from FizzBee spec: lambda_memorydb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingCluster

  Background:
    Given the system is initialized

  @minimal @happy @write_record @internal
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "memorydb" "cluster" was "AVAILABLE"
    And a "memorydb" "record" "slot" was "available"
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the "memorydb" "record" will exist in the "memorydb" "cluster" and the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing record references a "memorydb" "cluster" that exists

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when the "memorydb" "cluster" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "memorydb" "cluster" was not "AVAILABLE"
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected

  @guard @negative @write_record @internal
  Scenario: the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation fails when no "memorydb" "record" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "memorydb" "cluster" was "AVAILABLE"
    And no "memorydb" "record" "slot" was "available"
    When the "lambda" "function" writes a record to the "AVAILABLE" MemoryDB cluster during invocation
    Then the operation is rejected
