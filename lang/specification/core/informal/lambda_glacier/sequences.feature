@lambdaglacier @generated
Feature: LambdaGlacier - Action Sequences

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "glacier" "vault" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "glacier" "vault" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "lambda" "function" is deployed
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" is invoked
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "lambda" "function" is deployed
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" is invoked
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "glacier" "vault" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "glacier" "vault" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is created
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is deleted
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is created
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "glacier" "vault" is deleted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" is deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "lambda" "function" is deployed
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "lambda" "function" is deployed then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "lambda" "function" is deployed
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then a "glacier" "vault" is created then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is created
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: a "glacier" "vault" is deleted then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" is invoked
    Given vid in vault_status
    When a "glacier" "vault" is deleted
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "glacier" "vault" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "glacier" "vault" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "lambda" "function" is deployed then a "glacier" "vault" is created
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is created then a "glacier" "vault" is deleted
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is created
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "lambda" "function" is deployed then a "glacier" "vault" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "lambda" "function" is deployed
    When a "glacier" "vault" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then a "glacier" "vault" is deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When a "glacier" "vault" is deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @sequence
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted then the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds then a "glacier" "vault" is created
    Given iid in inv_status
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    When a "glacier" "vault" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists
