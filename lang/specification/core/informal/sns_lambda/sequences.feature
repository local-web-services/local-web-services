@snslambda @generated
Feature: SnsLambda - Action Sequences

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" is deployed
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then the "lambda" "function" invocation completes successfully
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then the "lambda" "function" invocation fails
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sns" "topic" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation completes successfully
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation fails
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" is deployed
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation completes successfully
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation fails
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sns" "topic" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sns" "topic" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation completes successfully
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "sns" "topic" is created then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then a "sns" "topic" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then a "lambda" "function" subscribes to a "sns" "topic"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "sns" "topic" is created then the "lambda" "function" invocation completes successfully
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created then the "lambda" "function" invocation fails
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" is deployed then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "sns" "topic" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "sns" "topic" is created
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the "lambda" "function" invocation fails
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "sns" "topic" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" subscribes to a "sns" "topic" then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the "lambda" "function" invocation completes successfully
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"
