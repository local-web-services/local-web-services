@lambdaglacier @generated
Feature: LambdaGlacier - Action Sequences

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then a Lambda function is deployed
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function is invoked
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then a Lambda function is deployed
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function is invoked
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function fails to upload because the vault has been deleted
    Given vid in vault_status
    Given a Glacier vault has been deleted
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is created then a Glacier vault is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is deleted then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Glacier vault has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then a Lambda function is deployed then the Lambda function is invoked
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a Glacier vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a Lambda function has been deployed
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given a Glacier vault has been created
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: a Glacier vault is deleted then the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked
    Given vid in vault_status
    Given a Glacier vault has been deleted
    Given the Lambda function has failed to upload because the vault has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Glacier vault has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is deleted then a Glacier vault is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Glacier vault has been deleted
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to upload because the vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed then a Glacier vault is created
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    Given a Lambda function has been deployed
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created then a Glacier vault is deleted
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    Given a Glacier vault has been created
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    Given a Glacier vault has been deleted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to upload because the vault has been deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    Given the Lambda function has failed to upload because the vault has been deleted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed then a Glacier vault is deleted
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    Given a Lambda function has been deployed
    When a Glacier vault is deleted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    Given a Glacier vault has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    Given a Glacier vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given iid in inv_status
    Given the Lambda function has failed to upload because the vault has been deleted
    Given the Lambda function has uploaded an archive to an existing vault and succeeded
    When a Glacier vault is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists
