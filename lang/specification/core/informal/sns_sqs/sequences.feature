@snssqs @generated
Feature: SnsSqs - Action Sequences

  # Generated from FizzBee spec: sns_sqs.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, MessagesReferenceActiveQueues, DeliveryRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SQS" queue is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SQS" queue subscribes to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is consumed from the "SQS" queue
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SNS" topic is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" queue subscribes to an "SNS" topic
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then an "SQS" queue is created
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then a message is consumed from the "SQS" queue
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SNS" topic is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue subscribes to an "SNS" topic
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then a message is consumed from the "SQS" queue
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SNS" topic is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue subscribes to an "SNS" topic
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SQS" queue is created then an "SQS" queue subscribes to an "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SQS" queue is created
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SQS" queue subscribes to an "SNS" topic then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then a message is consumed from the "SQS" queue
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is consumed from the "SQS" queue then an "SQS" queue is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SNS" topic is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SNS" topic is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" queue subscribes to an "SNS" topic then a message is consumed from the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SNS" topic is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a message is consumed from the "SQS" queue then an "SQS" queue subscribes to an "SNS" topic
    Given qid not in queue_status
    When an "SQS" queue is created
    When a message is consumed from the "SQS" queue
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then an "SNS" topic is created then a message is consumed from the "SQS" queue
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When an "SNS" topic is created
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then an "SQS" queue is created then an "SNS" topic is created
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When an "SQS" queue is created
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue is created
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: an "SQS" queue subscribes to an "SNS" topic then a message is consumed from the "SQS" queue then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given tid in topic_status
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is consumed from the "SQS" queue
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SNS" topic is created then an "SQS" queue is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SNS" topic is created
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue is created then an "SQS" queue subscribes to an "SNS" topic
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue is created
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue subscribes to an "SNS" topic then a message is consumed from the "SQS" queue
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue subscribes to an "SNS" topic
    When a message is consumed from the "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then a message is consumed from the "SQS" queue then an "SNS" topic is created
    Given tid in topic_status
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When a message is consumed from the "SQS" queue
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SNS" topic is created then an "SQS" queue subscribes to an "SNS" topic
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SNS" topic is created
    When an "SQS" queue subscribes to an "SNS" topic
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue is created then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue is created
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then an "SQS" queue subscribes to an "SNS" topic then an "SNS" topic is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When an "SQS" queue subscribes to an "SNS" topic
    When an "SNS" topic is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic

  @exhaustive @sequence
  Scenario: a message is consumed from the "SQS" queue then a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue then an "SQS" queue is created
    Given mid in msg_status
    When a message is consumed from the "SQS" queue
    When a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue
    When an "SQS" queue is created
    And every confirmed subscription references an "ACTIVE" "SNS" topic
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
    And a message can only be delivered if a confirmed subscription exists for the topic
