@cognitolambda @generated
Feature: CognitoLambda - Action Sequences

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a user signs up to a pool that has no pre-signup trigger configured
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then the pre-signup Lambda allows the signup
    Given pid not in pool_status
    When a Cognito User Pool is created
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then the pre-signup Lambda denies the signup
    Given pid not in pool_status
    When a Cognito User Pool is created
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito User Pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a user signs up to a pool that has no pre-signup trigger configured
    Given fid not in func_status
    When a Lambda function is deployed
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a user initiates signup to a pool that has a pre-signup trigger configured
    Given fid not in func_status
    When a Lambda function is deployed
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the pre-signup Lambda allows the signup
    Given fid not in func_status
    When a Lambda function is deployed
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the pre-signup Lambda denies the signup
    Given fid not in func_status
    When a Lambda function is deployed
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a Cognito User Pool is created
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a Lambda function is deployed
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a user signs up to a pool that has no pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Cognito User Pool is created
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Lambda function is deployed
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Cognito User Pool is created
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Lambda function is deployed
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a user signs up to a pool that has no pre-signup trigger configured
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Cognito User Pool is created
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Lambda function is deployed
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a user signs up to a pool that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a user initiates signup to a pool that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then the pre-signup Lambda denies the signup
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Cognito User Pool is created
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Lambda function is deployed
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a user signs up to a pool that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a user initiates signup to a pool that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then the pre-signup Lambda allows the signup
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a Lambda function is deployed then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a Lambda function is deployed
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a Lambda pre-signup trigger is configured on the Cognito User Pool then a user signs up to a pool that has no pre-signup trigger configured
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a user signs up to a pool that has no pre-signup trigger configured then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a user signs up to a pool that has no pre-signup trigger configured
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda allows the signup
    Given pid not in pool_status
    When a Cognito User Pool is created
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then the pre-signup Lambda allows the signup then the pre-signup Lambda denies the signup
    Given pid not in pool_status
    When a Cognito User Pool is created
    When the pre-signup Lambda allows the signup
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Cognito User Pool is created then the pre-signup Lambda denies the signup then a Lambda function is deployed
    Given pid not in pool_status
    When a Cognito User Pool is created
    When the pre-signup Lambda denies the signup
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Cognito User Pool is created then a user signs up to a pool that has no pre-signup trigger configured
    Given fid not in func_status
    When a Lambda function is deployed
    When a Cognito User Pool is created
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda pre-signup trigger is configured on the Cognito User Pool then a user initiates signup to a pool that has a pre-signup trigger configured
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda allows the signup
    Given fid not in func_status
    When a Lambda function is deployed
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda denies the signup
    Given fid not in func_status
    When a Lambda function is deployed
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the pre-signup Lambda allows the signup then a Cognito User Pool is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the pre-signup Lambda allows the signup
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the pre-signup Lambda denies the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given fid not in func_status
    When a Lambda function is deployed
    When the pre-signup Lambda denies the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a Cognito User Pool is created then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Cognito User Pool is created
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a Lambda function is deployed then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Lambda function is deployed
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then a user initiates signup to a pool that has a pre-signup trigger configured then a Cognito User Pool is created
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then the pre-signup Lambda allows the signup then a Lambda function is deployed
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When the pre-signup Lambda allows the signup
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a Lambda pre-signup trigger is configured on the Cognito User Pool then the pre-signup Lambda denies the signup then a user signs up to a pool that has no pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When the pre-signup Lambda denies the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Cognito User Pool is created then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Cognito User Pool is created
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Lambda function is deployed then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Lambda function is deployed
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the Cognito User Pool then a Cognito User Pool is created
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then a user initiates signup to a pool that has a pre-signup trigger configured then a Lambda function is deployed
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda allows the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda denies the signup then a user initiates signup to a pool that has a pre-signup trigger configured
    Given pid in pool_status
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Cognito User Pool is created then the pre-signup Lambda denies the signup
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Cognito User Pool is created
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Lambda function is deployed then a Cognito User Pool is created
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Lambda function is deployed
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a Lambda pre-signup trigger is configured on the Cognito User Pool then a Lambda function is deployed
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then a user signs up to a pool that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a user signs up to a pool that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda allows the signup then a user signs up to a pool that has no pre-signup trigger configured
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda denies the signup then the pre-signup Lambda allows the signup
    Given pid in pool_status
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Cognito User Pool is created then a Lambda function is deployed
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Cognito User Pool is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Lambda function is deployed then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Lambda function is deployed
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool then a user signs up to a pool that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a user signs up to a pool that has no pre-signup trigger configured then a user initiates signup to a pool that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then a user initiates signup to a pool that has a pre-signup trigger configured then the pre-signup Lambda denies the signup
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When the pre-signup Lambda denies the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda allows the signup then the pre-signup Lambda denies the signup then a Cognito User Pool is created
    Given iid in inv_status
    When the pre-signup Lambda allows the signup
    When the pre-signup Lambda denies the signup
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Cognito User Pool is created then a Lambda pre-signup trigger is configured on the Cognito User Pool
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Cognito User Pool is created
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Lambda function is deployed then a user signs up to a pool that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Lambda function is deployed
    When a user signs up to a pool that has no pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a Lambda pre-signup trigger is configured on the Cognito User Pool then a user initiates signup to a pool that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a Lambda pre-signup trigger is configured on the Cognito User Pool
    When a user initiates signup to a pool that has a pre-signup trigger configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a user signs up to a pool that has no pre-signup trigger configured then the pre-signup Lambda allows the signup
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a user signs up to a pool that has no pre-signup trigger configured
    When the pre-signup Lambda allows the signup
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then a user initiates signup to a pool that has a pre-signup trigger configured then a Cognito User Pool is created
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When a user initiates signup to a pool that has a pre-signup trigger configured
    When a Cognito User Pool is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @exhaustive @sequence
  Scenario: the pre-signup Lambda denies the signup then the pre-signup Lambda allows the signup then a Lambda function is deployed
    Given iid in inv_status
    When the pre-signup Lambda denies the signup
    When the pre-signup Lambda allows the signup
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation
