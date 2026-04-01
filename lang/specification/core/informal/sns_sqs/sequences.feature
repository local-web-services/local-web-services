@snssqs @generated
Feature: SnsSqs - Action Sequences

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "sns" "topic" is created then a "sqs" "queue" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a "sqs" "queue" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a message is consumed from the "sqs" "queue"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a "sns" "topic" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "queue" subscribes to a "sns" "topic"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a message is consumed from the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a "sqs" "queue" is created
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a message is consumed from the "sqs" "queue"
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a message is consumed from the "sqs" "queue"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sns" "topic" is created
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sqs" "queue" subscribes to a "sns" "topic"
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a "sqs" "queue" is created then a "sqs" "queue" subscribes to a "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sqs" "queue" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a "sqs" "queue" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a message is consumed from the "sqs" "queue"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sns" "topic" is created then a message is consumed from the "sqs" "queue" then a "sqs" "queue" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a "sns" "topic" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "sns" "topic" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "queue" subscribes to a "sns" "topic" then a message is consumed from the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sns" "topic" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" is created then a message is consumed from the "sqs" "queue" then a "sqs" "queue" subscribes to a "sns" "topic"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a "sns" "topic" is created then a message is consumed from the "sqs" "queue"
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a "sqs" "queue" is created then a "sns" "topic" is created
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a "sqs" "queue" is created
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" is created
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a "sqs" "queue" subscribes to a "sns" "topic" then a message is consumed from the "sqs" "queue" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given tid in topic_status
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is consumed from the "sqs" "queue"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sns" "topic" is created then a "sqs" "queue" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sns" "topic" is created
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" is created then a "sqs" "queue" subscribes to a "sns" "topic"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" subscribes to a "sns" "topic" then a message is consumed from the "sqs" "queue"
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a message is consumed from the "sqs" "queue"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a message is consumed from the "sqs" "queue" then a "sns" "topic" is created
    Given tid in topic_status
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a message is consumed from the "sqs" "queue"
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sns" "topic" is created then a "sqs" "queue" subscribes to a "sns" "topic"
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sns" "topic" is created
    When a "sqs" "queue" subscribes to a "sns" "topic"
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sqs" "queue" is created then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" is created
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a "sqs" "queue" subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a "sqs" "queue" subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @sequence
  Scenario: a message is consumed from the "sqs" "queue" then a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue then a "sqs" "queue" is created
    Given mid in msg_status
    When a message is consumed from the "sqs" "queue"
    When a message is published to a "sns" "topic" and delivered to the subscribed "SQS" queue
    When a "sqs" "queue" is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic
