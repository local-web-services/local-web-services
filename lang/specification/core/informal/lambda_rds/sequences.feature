@lambdards @generated
Feature: LambdaRds - Action Sequences

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "rds" "database instance" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then a Multi-"AZ" failover begins on the "rds" "instance"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the database is failing over
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then a "lambda" "function" is deployed
    Given did not in db_status
    When a "rds" "database instance" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then a Multi-"AZ" failover begins on the "rds" "instance"
    Given did not in db_status
    When a "rds" "database instance" is created
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" is invoked
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" fails to connect because the database is failing over
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then a "lambda" "function" is deployed
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then a "rds" "database instance" is created
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" is invoked
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" fails to connect because the database is failing over
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a "lambda" "function" is deployed
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a "rds" "database instance" is created
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "rds" "instance"
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" is invoked
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" fails to connect because the database is failing over
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "rds" "database instance" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a Multi-"AZ" failover begins on the "rds" "instance"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the database is failing over
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "rds" "database instance" is created
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "rds" "instance"
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "lambda" "function" fails to connect because the database is failing over
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a "rds" "database instance" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "rds" "instance"
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then a "rds" "database instance" is created then a Multi-"AZ" failover begins on the "rds" "instance"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "rds" "database instance" is created
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then a Multi-"AZ" failover begins on the "rds" "instance" then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "lambda" "function" fails to connect because the database is failing over
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the database is failing over then a "rds" "database instance" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the database is failing over
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then a "lambda" "function" is deployed then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    When a "rds" "database instance" is created
    When a "lambda" "function" is deployed
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" is invoked
    Given did not in db_status
    When a "rds" "database instance" is created
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the database is failing over
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "lambda" "function" is deployed
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a "rds" "database instance" is created then the "lambda" "function" fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "rds" "instance"
    Given did not in db_status
    When a "rds" "database instance" is created
    When the "lambda" "function" fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then a "rds" "database instance" is created then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "rds" "database instance" is created
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" fails to connect because the database is failing over
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "rds" "database instance" is created
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" fails to connect because the database is failing over then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" fails to connect because the database is failing over
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a "lambda" "function" is deployed then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a "rds" "database instance" is created then the "lambda" "function" fails to connect because the database is failing over
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a "rds" "database instance" is created
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "rds" "instance" then a "lambda" "function" is deployed
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" is invoked then a "rds" "database instance" is created
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" is invoked
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "rds" "instance"
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" is invoked
    Given did in db_status
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the database is failing over
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "rds" "database instance" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "rds" "database instance" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a Multi-"AZ" failover begins on the "rds" "instance" then a "rds" "database instance" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "rds" "instance"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "lambda" "function" is deployed then a "rds" "database instance" is created
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "lambda" "function" is deployed
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "rds" "database instance" is created then a Multi-"AZ" failover begins on the "rds" "instance"
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "rds" "database instance" is created
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "rds" "instance" then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the database is failing over
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the database is failing over
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then the "lambda" "function" fails to connect because the database is failing over then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the "lambda" "function" fails to connect because the database is failing over
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a "lambda" "function" is deployed then a Multi-"AZ" failover begins on the "rds" "instance"
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a "lambda" "function" is deployed
    When a Multi-"AZ" failover begins on the "rds" "instance"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a "rds" "database instance" is created then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a "rds" "database instance" is created
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "rds" "instance" then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "rds" "instance"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "rds" "instance" Multi-"AZ" failover completes and the new primary is promoted
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the database is failing over then the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds then a "rds" "database instance" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the database is failing over
    When the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a "rds" "database instance" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "rds" "database instance" it queried
