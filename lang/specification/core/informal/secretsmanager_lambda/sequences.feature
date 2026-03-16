@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - Action Sequences

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a secret is created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a Lambda rotation function is deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the rotation function is deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When a rotation is triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a secret is created in Secrets Manager
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a Lambda rotation function is deployed
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When the rotation function is deleted
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @exhaustive @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given iid in inv_status
    When the Lambda rotation function fails and the rotation is aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    When a rotation is triggered for the secret
    And every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated
