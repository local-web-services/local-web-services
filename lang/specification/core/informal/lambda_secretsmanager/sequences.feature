@lambdasecretsmanager @generated
Feature: LambdaSecretsmanager - Action Sequences

  # Generated from FizzBee spec: lambda_secretsmanager.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationReadASecret

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a secret is scheduled for deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed then the Lambda function is invoked
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then a Lambda function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then the Lambda function is invoked
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked then a Lambda function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid not in secret_status
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed then the Lambda function is invoked
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then a Lambda function is deployed
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then the Lambda function is invoked
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked then a Lambda function is deployed
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given sid in secret_status
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a secret is created in Secrets Manager
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a secret is scheduled for deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked then the Lambda function fails because the secret is pending deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    When the Lambda function fails because the secret is pending deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function fails because the secret is pending deletion then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a Lambda function is deployed then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a Lambda function is deployed
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is created in Secrets Manager then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is created in Secrets Manager
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then a secret is scheduled for deletion then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When a secret is scheduled for deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function is invoked then the Lambda function reads an "ACTIVE" secret and completes successfully
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function is invoked
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is created in Secrets Manager
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is created in Secrets Manager
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then a secret is scheduled for deletion
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When a secret is scheduled for deletion
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read

  @exhaustive @sequence
  Scenario: the Lambda function fails because the secret is pending deletion then the Lambda function reads an "ACTIVE" secret and completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails because the secret is pending deletion
    When the Lambda function reads an "ACTIVE" secret and completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which secret it read
