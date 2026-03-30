@sns @generated
Feature: Sns - Action Sequences

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a subscription is removed
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires
    Given sid in sub_status
    Given a pending subscription has been confirmed
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an "SNS" topic is created
    Given sid in sub_status
    Given a subscription has been removed
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted
    Given sid in sub_status
    Given a subscription has been removed
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a subscription has been removed
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed
    Given sid in sub_status
    Given a subscription has been removed
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a message is published to a topic
    Given sid in sub_status
    Given a subscription has been removed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds
    Given sid in sub_status
    Given a subscription has been removed
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a subscription has been removed
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted
    Given sid in sub_status
    Given a subscription has been removed
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires
    Given sid in sub_status
    Given a subscription has been removed
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created
    Given tarn in topic_status
    Given a message has been published to a topic
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted
    Given tarn in topic_status
    Given a message has been published to a topic
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic
    Given tarn in topic_status
    Given a message has been published to a topic
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed
    Given tarn in topic_status
    Given a message has been published to a topic
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a subscription is removed
    Given tarn in topic_status
    Given a message has been published to a topic
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds
    Given tarn in topic_status
    Given a message has been published to a topic
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given a message has been published to a topic
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    Given a message has been published to a topic
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    Given a message has been published to a topic
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires
    Given did in delivery_status
    Given a delivery attempt has succeeded
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires
    Given did in delivery_status
    Given all delivery retries have been exhausted
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted
    Given sid in sub_status
    Given a subscription confirmation token has expired
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given an "SNS" topic has been deleted
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given an endpoint has subscribed to a topic
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a pending subscription is confirmed then a subscription is removed
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a pending subscription has been confirmed
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a subscription is removed then a message is published to a topic
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a subscription has been removed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a message is published to a topic then a delivery attempt succeeds
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a message has been published to a topic
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a delivery attempt has succeeded
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a delivery attempt fails and is retried then all delivery retries are exhausted
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a delivery attempt has failed and been retried
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then all delivery retries are exhausted then a subscription confirmation token expires
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given all delivery retries have been exhausted
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is created then a subscription confirmation token expires then an "SNS" topic is deleted
    Given tarn not in topic_status
    Given an "SNS" topic has been created
    Given a subscription confirmation token has expired
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then an "SNS" topic is created then a pending subscription is confirmed
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given an "SNS" topic has been created
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then an endpoint subscribes to a topic then a subscription is removed
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given an endpoint has subscribed to a topic
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a pending subscription is confirmed then a message is published to a topic
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a pending subscription has been confirmed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a subscription is removed then a delivery attempt succeeds
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a subscription has been removed
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a message is published to a topic then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a message has been published to a topic
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt succeeds then all delivery retries are exhausted
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a delivery attempt has succeeded
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a delivery attempt has failed and been retried
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then all delivery retries are exhausted then an "SNS" topic is created
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given all delivery retries have been exhausted
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an "SNS" topic is deleted then a subscription confirmation token expires then an endpoint subscribes to a topic
    Given tarn in topic_status
    Given an "SNS" topic has been deleted
    Given a subscription confirmation token has expired
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is created then a subscription is removed
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given an "SNS" topic has been created
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then an "SNS" topic is deleted then a message is published to a topic
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given an "SNS" topic has been deleted
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a pending subscription is confirmed then a delivery attempt succeeds
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a pending subscription has been confirmed
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a subscription is removed then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a subscription has been removed
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a message is published to a topic then all delivery retries are exhausted
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a message has been published to a topic
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt succeeds then a subscription confirmation token expires
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a delivery attempt has succeeded
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a delivery attempt fails and is retried then an "SNS" topic is created
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a delivery attempt has failed and been retried
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then all delivery retries are exhausted then an "SNS" topic is deleted
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given all delivery retries have been exhausted
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a topic then a subscription confirmation token expires then a pending subscription is confirmed
    Given tarn in topic_status
    Given an endpoint has subscribed to a topic
    Given a subscription confirmation token has expired
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is created then a message is published to a topic
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given an "SNS" topic has been created
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an "SNS" topic is deleted then a delivery attempt succeeds
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given an "SNS" topic has been deleted
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then an endpoint subscribes to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given an endpoint has subscribed to a topic
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a subscription is removed then all delivery retries are exhausted
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given a subscription has been removed
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a message is published to a topic then a subscription confirmation token expires
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given a message has been published to a topic
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt succeeds then an "SNS" topic is created
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given a delivery attempt has succeeded
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a delivery attempt fails and is retried then an "SNS" topic is deleted
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given a delivery attempt has failed and been retried
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then all delivery retries are exhausted then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given all delivery retries have been exhausted
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a pending subscription is confirmed then a subscription confirmation token expires then a subscription is removed
    Given sid in sub_status
    Given a pending subscription has been confirmed
    Given a subscription confirmation token has expired
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an "SNS" topic is created then a delivery attempt succeeds
    Given sid in sub_status
    Given a subscription has been removed
    Given an "SNS" topic has been created
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an "SNS" topic is deleted then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a subscription has been removed
    Given an "SNS" topic has been deleted
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then an endpoint subscribes to a topic then all delivery retries are exhausted
    Given sid in sub_status
    Given a subscription has been removed
    Given an endpoint has subscribed to a topic
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a pending subscription is confirmed then a subscription confirmation token expires
    Given sid in sub_status
    Given a subscription has been removed
    Given a pending subscription has been confirmed
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a message is published to a topic then an "SNS" topic is created
    Given sid in sub_status
    Given a subscription has been removed
    Given a message has been published to a topic
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a delivery attempt succeeds then an "SNS" topic is deleted
    Given sid in sub_status
    Given a subscription has been removed
    Given a delivery attempt has succeeded
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a delivery attempt fails and is retried then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a subscription has been removed
    Given a delivery attempt has failed and been retried
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then all delivery retries are exhausted then a pending subscription is confirmed
    Given sid in sub_status
    Given a subscription has been removed
    Given all delivery retries have been exhausted
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription is removed then a subscription confirmation token expires then a message is published to a topic
    Given sid in sub_status
    Given a subscription has been removed
    Given a subscription confirmation token has expired
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an "SNS" topic is created then a delivery attempt fails and is retried
    Given tarn in topic_status
    Given a message has been published to a topic
    Given an "SNS" topic has been created
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an "SNS" topic is deleted then all delivery retries are exhausted
    Given tarn in topic_status
    Given a message has been published to a topic
    Given an "SNS" topic has been deleted
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then an endpoint subscribes to a topic then a subscription confirmation token expires
    Given tarn in topic_status
    Given a message has been published to a topic
    Given an endpoint has subscribed to a topic
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a pending subscription is confirmed then an "SNS" topic is created
    Given tarn in topic_status
    Given a message has been published to a topic
    Given a pending subscription has been confirmed
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a subscription is removed then an "SNS" topic is deleted
    Given tarn in topic_status
    Given a message has been published to a topic
    Given a subscription has been removed
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a delivery attempt succeeds then an endpoint subscribes to a topic
    Given tarn in topic_status
    Given a message has been published to a topic
    Given a delivery attempt has succeeded
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a delivery attempt fails and is retried then a pending subscription is confirmed
    Given tarn in topic_status
    Given a message has been published to a topic
    Given a delivery attempt has failed and been retried
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then all delivery retries are exhausted then a subscription is removed
    Given tarn in topic_status
    Given a message has been published to a topic
    Given all delivery retries have been exhausted
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a message is published to a topic then a subscription confirmation token expires then a delivery attempt succeeds
    Given tarn in topic_status
    Given a message has been published to a topic
    Given a subscription confirmation token has expired
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is created then all delivery retries are exhausted
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given an "SNS" topic has been created
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an "SNS" topic is deleted then a subscription confirmation token expires
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given an "SNS" topic has been deleted
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then an endpoint subscribes to a topic then an "SNS" topic is created
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given an endpoint has subscribed to a topic
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a pending subscription is confirmed then an "SNS" topic is deleted
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given a pending subscription has been confirmed
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a subscription is removed then an endpoint subscribes to a topic
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given a subscription has been removed
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a message is published to a topic then a pending subscription is confirmed
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given a message has been published to a topic
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a delivery attempt fails and is retried then a subscription is removed
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given a delivery attempt has failed and been retried
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then all delivery retries are exhausted then a message is published to a topic
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given all delivery retries have been exhausted
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt succeeds then a subscription confirmation token expires then a delivery attempt fails and is retried
    Given did in delivery_status
    Given a delivery attempt has succeeded
    Given a subscription confirmation token has expired
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is created then a subscription confirmation token expires
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given an "SNS" topic has been created
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an "SNS" topic is deleted then an "SNS" topic is created
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given an "SNS" topic has been deleted
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then an endpoint subscribes to a topic then an "SNS" topic is deleted
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given an endpoint has subscribed to a topic
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a pending subscription is confirmed then an endpoint subscribes to a topic
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given a pending subscription has been confirmed
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a subscription is removed then a pending subscription is confirmed
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given a subscription has been removed
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a message is published to a topic then a subscription is removed
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given a message has been published to a topic
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a delivery attempt succeeds then a message is published to a topic
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given a delivery attempt has succeeded
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then all delivery retries are exhausted then a delivery attempt succeeds
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given all delivery retries have been exhausted
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a delivery attempt fails and is retried then a subscription confirmation token expires then all delivery retries are exhausted
    Given did in delivery_status
    Given a delivery attempt has failed and been retried
    Given a subscription confirmation token has expired
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is created then an "SNS" topic is deleted
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given an "SNS" topic has been created
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an "SNS" topic is deleted then an endpoint subscribes to a topic
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given an "SNS" topic has been deleted
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then an endpoint subscribes to a topic then a pending subscription is confirmed
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given an endpoint has subscribed to a topic
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a pending subscription is confirmed then a subscription is removed
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a pending subscription has been confirmed
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a subscription is removed then a message is published to a topic
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a subscription has been removed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a message is published to a topic then a delivery attempt succeeds
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a message has been published to a topic
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt succeeds then a delivery attempt fails and is retried
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a delivery attempt has succeeded
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a delivery attempt fails and is retried then a subscription confirmation token expires
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a delivery attempt has failed and been retried
    When a subscription confirmation token expires
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: all delivery retries are exhausted then a subscription confirmation token expires then an "SNS" topic is created
    Given did in delivery_status
    Given all delivery retries have been exhausted
    Given a subscription confirmation token has expired
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is created then an endpoint subscribes to a topic
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given an "SNS" topic has been created
    When an endpoint subscribes to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an "SNS" topic is deleted then a pending subscription is confirmed
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given an "SNS" topic has been deleted
    When a pending subscription is confirmed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then an endpoint subscribes to a topic then a subscription is removed
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given an endpoint has subscribed to a topic
    When a subscription is removed
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a pending subscription is confirmed then a message is published to a topic
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given a pending subscription has been confirmed
    When a message is published to a topic
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a subscription is removed then a delivery attempt succeeds
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given a subscription has been removed
    When a delivery attempt succeeds
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a message is published to a topic then a delivery attempt fails and is retried
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given a message has been published to a topic
    When a delivery attempt fails and is retried
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt succeeds then all delivery retries are exhausted
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given a delivery attempt has succeeded
    When all delivery retries are exhausted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then a delivery attempt fails and is retried then an "SNS" topic is created
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given a delivery attempt has failed and been retried
    When an "SNS" topic is created
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit

  @sequence
  Scenario: a subscription confirmation token expires then all delivery retries are exhausted then an "SNS" topic is deleted
    Given sid in sub_status
    Given a subscription confirmation token has expired
    Given all delivery retries have been exhausted
    When an "SNS" topic is deleted
    Then no delivery is in-flight to a deleted subscription
    And no delivery is in-flight to an unconfirmed subscription
    And every active subscription references an "ACTIVE" topic
    And every delivery retry count is within the allowed limit
