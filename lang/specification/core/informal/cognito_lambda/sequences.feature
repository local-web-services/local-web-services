@cognitolambda @generated
Feature: CognitoLambda - Action Sequences

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "cognito" "user pool" is created then a "lambda" "function" is deployed
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then the pre-signup "lambda" "function" allows the signup
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then the pre-signup "lambda" "function" denies the signup
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then the pre-signup "lambda" "function" allows the signup
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then the pre-signup "lambda" "function" denies the signup
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user pool" is created
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "lambda" "function" is deployed
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user pool" is created
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "lambda" "function" is deployed
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then the pre-signup "lambda" "function" denies the signup
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user pool" is created
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "lambda" "function" is deployed
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then the pre-signup "lambda" "function" allows the signup
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a "lambda" "function" is deployed then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then the pre-signup "lambda" "function" allows the signup then the pre-signup "lambda" "function" denies the signup
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" allows the signup
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user pool" is created then the pre-signup "lambda" "function" denies the signup then a "lambda" "function" is deployed
    Given pid not in pool_status
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" denies the signup
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user pool" is created then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then the pre-signup "lambda" "function" allows the signup then a "cognito" "user pool" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "lambda" "function" is deployed then the pre-signup "lambda" "function" denies the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" denies the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user pool" is created then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user pool" is created
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "lambda" "function" is deployed then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user pool" is created
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then the pre-signup "lambda" "function" allows the signup then a "lambda" "function" is deployed
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When the pre-signup "lambda" "function" allows the signup
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a Lambda pre-signup trigger is configured on the "cognito" "user pool" then the pre-signup "lambda" "function" denies the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid in pool_status
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user pool" is created then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "lambda" "function" is deployed then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "lambda" "function" is deployed
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given pid in pool_status
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user pool" is created then the pre-signup "lambda" "function" denies the signup
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user pool" is created
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "lambda" "function" is deployed then a "cognito" "user pool" is created
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "lambda" "function" is deployed
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "lambda" "function" is deployed
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup then the pre-signup "lambda" "function" allows the signup
    Given pid in pool_status
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user pool" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user pool" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "lambda" "function" is deployed then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "lambda" "function" is deployed
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then the pre-signup "lambda" "function" denies the signup
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When the pre-signup "lambda" "function" denies the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" allows the signup then the pre-signup "lambda" "function" denies the signup then a "cognito" "user pool" is created
    Given iid in inv_status
    When the pre-signup "lambda" "function" allows the signup
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user pool" is created then a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user pool" is created
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "lambda" "function" is deployed then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "lambda" "function" is deployed
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a Lambda pre-signup trigger is configured on the "cognito" "user pool" then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a Lambda pre-signup trigger is configured on the "cognito" "user pool"
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured then the pre-signup "lambda" "function" allows the signup
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" signs up to a "cognito" "user pool" that has no pre-signup trigger configured
    When the pre-signup "lambda" "function" allows the signup
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured then a "cognito" "user pool" is created
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When a "cognito" "user" initiates signup to a "cognito" "user pool" that has a pre-signup trigger configured
    When a "cognito" "user pool" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @sequence
  Scenario: the pre-signup "lambda" "function" denies the signup then the pre-signup "lambda" "function" allows the signup then a "lambda" "function" is deployed
    Given iid in inv_status
    When the pre-signup "lambda" "function" denies the signup
    When the pre-signup "lambda" "function" allows the signup
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"
