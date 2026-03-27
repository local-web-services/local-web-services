@snslambda @generated
Feature: SnsLambda - Action Sequences

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation fails
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function is deployed
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function subscribes to an "SNS" topic
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a Lambda function has been deployed
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a Lambda function has subscribed to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then a Lambda function is deployed
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "SNS" topic has been created
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Lambda function has subscribed to an "SNS" topic
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an "SNS" topic is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then an "SNS" topic is created then the Lambda invocation completes successfully
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    Given an "SNS" topic has been created
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed then the Lambda invocation fails
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully then a Lambda function is deployed
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a Lambda function subscribes to an "SNS" topic then the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given tid in topic_status
    Given a Lambda function has subscribed to an "SNS" topic
    Given the Lambda invocation has failed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created then the Lambda invocation fails
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    Given an "SNS" topic has been created
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function is deployed then an "SNS" topic is created
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    Given a Lambda function has been deployed
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then a Lambda function subscribes to an "SNS" topic then a Lambda function is deployed
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    Given a Lambda function has subscribed to an "SNS" topic
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    Given the Lambda invocation has completed successfully
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given tid in topic_status
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an "SNS" topic has been created
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function subscribes to an "SNS" topic then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has subscribed to an "SNS" topic
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When the Lambda invocation fails
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then a Lambda function subscribes to an "SNS" topic
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an "SNS" topic has been created
    When a Lambda function subscribes to an "SNS" topic
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function subscribes to an "SNS" topic then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has subscribed to an "SNS" topic
    When the Lambda invocation completes successfully
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a message is published to an "SNS" topic and asynchronously invokes the subscribed Lambda function then an "SNS" topic is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a message has been published to an "SNS" topic and asynchronously invoked the subscribed Lambda function
    When an "SNS" topic is created
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "CONFIRMED" subscription references an "ACTIVE" "SNS" topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by a "CONFIRMED" subscription
