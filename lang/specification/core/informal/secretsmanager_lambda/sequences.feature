@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - Action Sequences

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "rotation function" is deployed
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a rotation is triggered for the "secretsmanager" "secret"
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" is deleted
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then a rotation is triggered for the "secretsmanager" "secret"
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" fails and the rotation is aborted
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a "lambda" "rotation function" is deployed
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a rotation is triggered for the "secretsmanager" "secret"
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then the "lambda" "rotation function" fails and the rotation is aborted
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a "lambda" "rotation function" is deployed
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" is deleted
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a rotation is triggered for the "secretsmanager" "secret"
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then a "lambda" "rotation function" is deployed
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" is deleted
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "lambda" "rotation function" is deployed
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" is deleted
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a rotation is triggered for the "secretsmanager" "secret"
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" fails and the rotation is aborted
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a "lambda" "rotation function" is deployed
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" is deleted
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a rotation is triggered for the "secretsmanager" "secret"
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "rotation function" is deployed then the "lambda" "rotation function" is deleted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" is deleted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" is deleted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a rotation is triggered for the "secretsmanager" "secret"
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" fails and the rotation is aborted then a "lambda" "rotation function" is deployed
    Given sid not in secret_status
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" is deleted then a rotation is triggered for the "secretsmanager" "secret"
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" is deleted
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" fails and the rotation is aborted
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a "lambda" "rotation function" is deployed then the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" is deleted
    Given fid not in func_status
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a "secretsmanager" "secret" is created in Secrets Manager then a rotation is triggered for the "secretsmanager" "secret"
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a "lambda" "rotation function" is deployed then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" fails and the rotation is aborted
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then a rotation is triggered for the "secretsmanager" "secret" then a "secretsmanager" "secret" is created in Secrets Manager
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "lambda" "rotation function" is deployed
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" is deleted then the "lambda" "rotation function" fails and the rotation is aborted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given fid in func_status
    When the "lambda" "rotation function" is deleted
    When the "lambda" "rotation function" fails and the rotation is aborted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a "lambda" "rotation function" is deployed then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" is deleted then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" is deleted
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a rotation is triggered for the "secretsmanager" "secret" then a "lambda" "rotation function" is deployed
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" is deleted
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" fails and the rotation is aborted then a rotation is triggered for the "secretsmanager" "secret"
    Given sid in secret_status
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then a "lambda" "rotation function" is deployed then a "secretsmanager" "secret" is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "lambda" "rotation function" is deployed
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" is deleted then a "lambda" "rotation function" is deployed
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" is deleted
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" is deleted
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "secretsmanager" "secret" is created in Secrets Manager then a "lambda" "rotation function" is deployed
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "secretsmanager" "secret" is created in Secrets Manager
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "lambda" "rotation function" is deployed then the "lambda" "rotation function" is deleted
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "lambda" "rotation function" is deployed
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" is deleted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" is deleted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then a rotation is triggered for the "secretsmanager" "secret"
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a rotation is triggered for the "secretsmanager" "secret" then the "lambda" "rotation function" fails and the rotation is aborted
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a rotation is triggered for the "secretsmanager" "secret"
    When the "lambda" "rotation function" fails and the rotation is aborted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then the "lambda" "rotation function" fails and the rotation is aborted then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a "secretsmanager" "secret" is created in Secrets Manager then the "lambda" "rotation function" is deleted
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "secretsmanager" "secret" is created in Secrets Manager
    When the "lambda" "rotation function" is deleted
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a "lambda" "rotation function" is deployed then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a "lambda" "rotation function" is deployed
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" is deleted then a rotation is triggered for the "secretsmanager" "secret"
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" is deleted
    When a rotation is triggered for the "secretsmanager" "secret"
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then a rotation is triggered for the "secretsmanager" "secret" then a "secretsmanager" "secret" is created in Secrets Manager
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When a rotation is triggered for the "secretsmanager" "secret"
    When a "secretsmanager" "secret" is created in Secrets Manager
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated

  @sequence
  Scenario: the "lambda" "rotation function" fails and the rotation is aborted then the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version then a "lambda" "rotation function" is deployed
    Given iid in inv_status
    When the "lambda" "rotation function" fails and the rotation is aborted
    When the "lambda" "rotation function" succeeds and the "secretsmanager" "secret" is rotated to a new version
    When a "lambda" "rotation function" is deployed
    And every "ROTATING" "secrets manager" "secret" has an "IN_PROGRESS" "lambda" "rotation invocation"
    And every successful "lambda" "rotation invocation" recorded which "secrets manager" "secret" it rotated
