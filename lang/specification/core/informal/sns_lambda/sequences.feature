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
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then the Lambda invocation completes successfully
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then the Lambda invocation fails
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sns" "topic" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation completes successfully
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation fails
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" is deployed
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "sns" "topic" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "sns" "topic" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "sns" "topic" is created then the Lambda invocation fails then a "lambda" "function" is deployed
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a "sns" "topic" is created then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully then a "sns" "topic" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails then a "lambda" "function" subscribes to a "sns" "topic"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "sns" "topic" is created then the Lambda invocation completes successfully
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed then the Lambda invocation fails
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created then the Lambda invocation fails
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" is deployed then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" is deployed
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "lambda" "function" subscribes to a "sns" "topic" then a "lambda" "function" is deployed
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given tid in topic_status
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "sns" "topic" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "sns" "topic" is created
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a "sns" "topic" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "sns" "topic" is created then a "lambda" "function" subscribes to a "sns" "topic"
    Given iid in inv_status
    When the Lambda invocation fails
    When a "sns" "topic" is created
    When a "lambda" "function" subscribes to a "sns" "topic"
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" subscribes to a "sns" "topic" then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" subscribes to a "sns" "topic"
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function then a "sns" "topic" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a message is published to a "sns" "topic" and asynchronously invokes the subscribed Lambda function
    When a "sns" "topic" is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription
