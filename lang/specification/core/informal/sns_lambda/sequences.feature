@snslambda @generated
Feature: SnsLambda - Action Sequences

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation fails
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function is deployed
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function subscribes to an "SNS" topic
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then an "SNS" topic is created then the Lambda invocation completes successfully
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed then the Lambda invocation fails
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully then a Lambda function is deployed
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation fails
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created then the Lambda invocation fails
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function is deployed then an "SNS" topic is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When a Lambda function subscribes to an "SNS" topic
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation completes successfully
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given tid in topic_status
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When the Lambda invocation fails
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    When a Lambda function subscribes to an "SNS" topic
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function subscribes to an "SNS" topic
    When the Lambda invocation completes successfully
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    When an "SNS" topic is created
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription
