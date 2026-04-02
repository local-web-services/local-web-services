@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - Action Sequences

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "secretsmanager" "secret" is scheduled for deletion
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "function" is deployed
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" is invoked
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "lambda" "function" is deployed
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" is invoked
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "secretsmanager" "secret" is scheduled for deletion
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is scheduled for deletion
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is scheduled for deletion
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" reads an "ACTIVE" secret and completes successfully then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" is invoked then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "lambda" "function" is deployed
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is scheduled for deletion
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "lambda" "function" is deployed then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "lambda" "function" is deployed
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" is invoked
    Given sid in secret_status
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then a "secretsmanager" "secret" is scheduled for deletion then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "secretsmanager" "secret" is scheduled for deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is scheduled for deletion
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "lambda" "function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is created in Secrets Manager then a "secretsmanager" "secret" is scheduled for deletion
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then the "lambda" "function" is invoked then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" reads an "ACTIVE" secret and completes successfully then the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "lambda" "function" is deployed then a "secretsmanager" "secret" is scheduled for deletion
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "lambda" "function" is deployed
    When a "secretsmanager" "secret" is scheduled for deletion
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then a "secretsmanager" "secret" is scheduled for deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When a "secretsmanager" "secret" is scheduled for deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read

  @sequence
  Scenario: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion then the "lambda" "function" reads an "ACTIVE" secret and completes successfully then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion
    When the "lambda" "function" reads an "ACTIVE" secret and completes successfully
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "secrets manager" "secret" it read
