@lambdaglacier @generated
Feature: LambdaGlacier - Action Sequences

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Lambda function is deployed
    Given vid not in vault_status
    When a Glacier vault is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function is invoked
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Lambda function is deployed
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function is invoked
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function fails to upload because the vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is created then a Glacier vault is deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Glacier vault is deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Glacier vault is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function uploads an archive to an existing vault and succeeds
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Lambda function is deployed then the Lambda function is invoked
    Given vid not in vault_status
    When a Glacier vault is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier vault is deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function is invoked
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Lambda function is deployed then the Lambda function uploads an archive to an existing vault and succeeds
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Lambda function is deployed
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then a Glacier vault is created then the Lambda function fails to upload because the vault has been deleted
    Given vid in vault_status
    When a Glacier vault is deleted
    When a Glacier vault is created
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function is invoked then a Lambda function is deployed
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is deleted then the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked
    Given vid in vault_status
    When a Glacier vault is deleted
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to upload because the vault has been deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Glacier vault is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Glacier vault is deleted then a Glacier vault is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Glacier vault is deleted
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Lambda function is deployed then a Glacier vault is created
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Lambda function is deployed
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created then a Glacier vault is deleted
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is created
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function is invoked then the Lambda function fails to upload because the vault has been deleted
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to upload because the vault has been deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds then the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function uploads an archive to an existing vault and succeeds
    When the Lambda function fails to upload because the vault has been deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Lambda function is deployed then a Glacier vault is deleted
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Lambda function is deployed
    When a Glacier vault is deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then a Glacier vault is deleted then the Lambda function uploads an archive to an existing vault and succeeds
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When a Glacier vault is deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to upload because the vault has been deleted then the Lambda function uploads an archive to an existing vault and succeeds then a Glacier vault is created
    Given iid in inv_status
    When the Lambda function fails to upload because the vault has been deleted
    When the Lambda function uploads an archive to an existing vault and succeeds
    When a Glacier vault is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists
