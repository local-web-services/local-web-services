@sns @generated
Feature: Sns - Action Sequences

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a subscription confirmation token expires
    Given tarn not in topic_status
    When an "SNS" topic is created
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then an "SNS" topic is deleted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then a pending subscription is confirmed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then a subscription is removed
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then a message is published to a topic
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then a delivery attempt succeeds
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then all delivery retries are exhausted
    Given tarn not in topic_status
    When an "SNS" topic is created
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then a subscription confirmation token expires
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then an "SNS" topic is created
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then a pending subscription is confirmed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then a subscription is removed
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then a message is published to a topic
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then a delivery attempt succeeds
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then all delivery retries are exhausted
    Given tarn in topic_status
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then a subscription confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then an "SNS" topic is created
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then an "SNS" topic is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a pending subscription is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a subscription is removed
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a message is published to a topic
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a delivery attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then all delivery retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then a subscription confirmation token expires
    Given sid in sub_status
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then an "SNS" topic is created
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then an "SNS" topic is deleted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then a subscription is removed
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then a message is published to a topic
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then a delivery attempt succeeds
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then all delivery retries are exhausted
    Given sid in sub_status
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a message is published to a topic then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a subscription confirmation token expires
    Given sid in sub_status
    When a subscription is removed
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then an "SNS" topic is created
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then a message is published to a topic
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription is removed
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription is removed then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a subscription confirmation token expires
    Given tarn in topic_status
    When a message is published to a topic
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then an "SNS" topic is created
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then an "SNS" topic is deleted
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then a pending subscription is confirmed
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then a subscription is removed
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then a delivery attempt succeeds
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then all delivery retries are exhausted
    Given tarn in topic_status
    When a message is published to a topic
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then a subscription is removed
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a subscription confirmation token expires
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then an "SNS" topic is created
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then an "SNS" topic is deleted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then a pending subscription is confirmed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then a subscription is removed
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then a message is published to a topic
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then a delivery attempt succeeds
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then all delivery retries are exhausted
    Given did in delivery_status
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is created
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription is removed
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a message is published to a topic
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given did in delivery_status
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    When a subscription confirmation token expires
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then an "SNS" topic is created
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then an "SNS" topic is deleted
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then a pending subscription is confirmed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then a subscription is removed
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then a message is published to a topic
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then a delivery attempt succeeds
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given did in delivery_status
    When all delivery retries are exhausted
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is created
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an "SNS" topic is deleted
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When an endpoint subscribes to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a pending subscription is confirmed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a subscription is removed
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a message is published to a topic
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt succeeds
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given sid in sub_status
    When a subscription confirmation token expires
    When a delivery attempt fails and is retried
    When all delivery retries are exhausted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then an "SNS" topic is created
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When an "SNS" topic is created
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then an "SNS" topic is deleted
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When an "SNS" topic is deleted
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When an endpoint subscribes to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then a pending subscription is confirmed
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When a pending subscription is confirmed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then a subscription is removed
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When a subscription is removed
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then a message is published to a topic
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When a message is published to a topic
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then a delivery attempt succeeds
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When a delivery attempt succeeds
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @exhaustive @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then a delivery attempt fails and is retried
    Given sid in sub_status
    When a subscription confirmation token expires
    When all delivery retries are exhausted
    When a delivery attempt fails and is retried
    And no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit
