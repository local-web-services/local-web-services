@secretsmanagerlambda @generated
Feature: SecretsmanagerLambda - Action Sequences

  # Generated from FizzBee spec: secretsmanager_lambda.fizz
  # Safety invariants: RotatingSecretHasInProgressInvocation, SuccessfulRotationRotatedASecret

  Background:
    Given the system is initialized

  @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager
    Given fid in func_status
    Given the rotation function has been deleted
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed
    Given fid in func_status
    Given the rotation function has been deleted
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    Given the rotation function has been deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret
    Given fid in func_status
    Given the rotation function has been deleted
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    Given the rotation function has been deleted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    Given the rotation function has been deleted
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda rotation function is deployed then the rotation function is deleted
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a Lambda rotation function has been deployed
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the rotation function has been deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a rotation has been triggered for the secret
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then a secret is created in Secrets Manager then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given a secret has been created in Secrets Manager
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the rotation function is deleted then a rotation is triggered for the secret
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given the rotation function has been deleted
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given a rotation has been triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted
    Given fid not in func_status
    Given a Lambda rotation function has been deployed
    Given the Lambda rotation function has failed and the rotation has been aborted
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a secret is created in Secrets Manager then a rotation is triggered for the secret
    Given fid in func_status
    Given the rotation function has been deleted
    Given a secret has been created in Secrets Manager
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a Lambda rotation function is deployed then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given fid in func_status
    Given the rotation function has been deleted
    Given a Lambda rotation function has been deployed
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted
    Given fid in func_status
    Given the rotation function has been deleted
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given fid in func_status
    Given the rotation function has been deleted
    Given a rotation has been triggered for the secret
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given fid in func_status
    Given the rotation function has been deleted
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the rotation function is deleted then the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function
    Given fid in func_status
    Given the rotation function has been deleted
    Given the Lambda rotation function has failed and the rotation has been aborted
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a secret is created in Secrets Manager then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given a secret has been created in Secrets Manager
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a Lambda rotation function is deployed then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given a Lambda rotation function has been deployed
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted then a secret is created in Secrets Manager
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given the rotation function has been deleted
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret then a Lambda rotation function is deployed
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given a rotation has been triggered for the secret
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret
    Given sid in secret_status
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then a secret is created in Secrets Manager then the Lambda rotation function fails and the rotation is aborted
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given a secret has been created in Secrets Manager
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then a Lambda rotation function is deployed then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given a Lambda rotation function has been deployed
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the rotation function is deleted then a Lambda rotation function is deployed
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given the rotation function has been deleted
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then rotation is configured on the secret linking it to the Lambda rotation function then the rotation function is deleted
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given sid in secret_status
    Given a rotation has been triggered for the secret
    Given the Lambda rotation function has failed and the rotation has been aborted
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a secret is created in Secrets Manager then a Lambda rotation function is deployed
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given a secret has been created in Secrets Manager
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed then the rotation function is deleted
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given a Lambda rotation function has been deployed
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the rotation function is deleted then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given the rotation function has been deleted
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then rotation is configured on the secret linking it to the Lambda rotation function then a rotation is triggered for the secret
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then a rotation is triggered for the secret then the Lambda rotation function fails and the rotation is aborted
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given a rotation has been triggered for the secret
    When the Lambda rotation function fails and the rotation is aborted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function succeeds and the secret is rotated to a new version then the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    Given the Lambda rotation function has failed and the rotation has been aborted
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a secret is created in Secrets Manager then the rotation function is deleted
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given a secret has been created in Secrets Manager
    When the rotation function is deleted
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a Lambda rotation function is deployed then rotation is configured on the secret linking it to the Lambda rotation function
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given a Lambda rotation function has been deployed
    When rotation is configured on the secret linking it to the Lambda rotation function
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the rotation function is deleted then a rotation is triggered for the secret
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given the rotation function has been deleted
    When a rotation is triggered for the secret
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then rotation is configured on the secret linking it to the Lambda rotation function then the Lambda rotation function succeeds and the secret is rotated to a new version
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given rotation has been configured on the secret linking it to the Lambda rotation function
    When the Lambda rotation function succeeds and the secret is rotated to a new version
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then a rotation is triggered for the secret then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given a rotation has been triggered for the secret
    When a secret is created in Secrets Manager
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated

  @sequence
  Scenario: the Lambda rotation function fails and the rotation is aborted then the Lambda rotation function succeeds and the secret is rotated to a new version then a Lambda rotation function is deployed
    Given iid in inv_status
    Given the Lambda rotation function has failed and the rotation has been aborted
    Given the Lambda rotation function has succeeded and the secret has been rotated to a new version
    When a Lambda rotation function is deployed
    Then every "ROTATING" secret has an "IN_PROGRESS" rotation invocation
    And every successful rotation invocation recorded which secret it rotated
