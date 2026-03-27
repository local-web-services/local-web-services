@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - Action Sequences

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager
    Given fid in func_status
    Given the Lambda function has been invoked
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion
    Given fid in func_status
    Given the Lambda function has been invoked
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a secret has been scheduled for deletion
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed because the secret is pending deletion
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed then the Lambda function is invoked
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given a secret has been scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the Lambda function has been invoked
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given sid not in secret_status
    Given a secret has been created in Secrets Manager
    Given the Lambda function has failed because the secret is pending deletion
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a Lambda function has been deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given a secret has been created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked then a Lambda function is deployed
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given sid in secret_status
    Given a secret has been scheduled for deletion
    Given the Lambda function has failed because the secret is pending deletion
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a secret has been created in Secrets Manager
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a secret has been scheduled for deletion
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    Given a Lambda function has been deployed
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    Given a secret has been created in Secrets Manager
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    Given a secret has been scheduled for deletion
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    Given the Lambda function has been invoked
    When the Lambda function fails because the secret is pending deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    Given the Lambda function has failed because the secret is pending deletion
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed then a secret is scheduled for deletion
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    Given a Lambda function has been deployed
    When a secret is scheduled for deletion
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    Given a secret has been created in Secrets Manager
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    Given a secret has been scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given iid in inv_status
    Given the Lambda function has failed because the secret is pending deletion
    Given the Lambda function has read an "ACTIVE" secret and completed successfully
    When a secret is created in Secrets Manager
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read
