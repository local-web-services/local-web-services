@sns @generated
Feature: Sns - Action Sequences

  # Generated from FizzBee spec: sns.fizz
  # Safety invariants: NoDeliveryToDeletedSubscription, NoDeliveryToUnconfirmedSubscription, SubscriptionsReferActiveTopic, RetryCountBounded

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "topic" is deleted
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then an endpoint subscribes to a "sns" "topic"
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a pending "sns" "subscription" is confirmed
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "subscription" is removed
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "message" is published to a "sns" "topic"
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "delivery" attempt succeeds
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "delivery" attempt fails and is retried
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then all "sns" "delivery" retries are exhausted
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "subscription" confirmation token expires
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "topic" is created
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then an endpoint subscribes to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "subscription" is removed
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "message" is published to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" is removed
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "message" is published to a "sns" "topic"
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "topic" is created
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "topic" is deleted
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "subscription" is removed
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "subscription" confirmation token expires
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "topic" is created
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "topic" is deleted
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a pending "sns" "subscription" is confirmed
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "subscription" confirmation token expires
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "topic" is created
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "topic" is deleted
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then an endpoint subscribes to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" is removed
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "topic" is created
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "topic" is deleted
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "subscription" is removed
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "delivery" attempt fails and is retried
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then all "sns" "delivery" retries are exhausted
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is created
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is deleted
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" is removed
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "delivery" attempt succeeds
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then all "sns" "delivery" retries are exhausted
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "topic" is created
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "topic" is deleted
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "subscription" is removed
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "delivery" attempt succeeds
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "delivery" attempt fails and is retried
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "topic" is created
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "topic" is deleted
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a pending "sns" "subscription" is confirmed
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "subscription" is removed
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "topic" is deleted then an endpoint subscribes to a "sns" "topic"
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "topic" is deleted
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then an endpoint subscribes to a "sns" "topic" then a pending "sns" "subscription" is confirmed
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When an endpoint subscribes to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a pending "sns" "subscription" is confirmed then a "sns" "subscription" is removed
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "subscription" is removed then a "sns" "message" is published to a "sns" "topic"
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "subscription" is removed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt succeeds
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "delivery" attempt succeeds then a "sns" "delivery" attempt fails and is retried
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt succeeds
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "delivery" attempt fails and is retried then all "sns" "delivery" retries are exhausted
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt fails and is retried
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then all "sns" "delivery" retries are exhausted then a "sns" "subscription" confirmation token expires
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" "subscription" confirmation token expires then a "sns" "topic" is deleted
    Given tarn not in topic_status
    When a "sns" "topic" is created
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "topic" is created then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "topic" is created
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" is removed
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a pending "sns" "subscription" is confirmed then a "sns" "message" is published to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a pending "sns" "subscription" is confirmed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "subscription" is removed then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "delivery" attempt succeeds then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt succeeds
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then all "sns" "delivery" retries are exhausted then a "sns" "topic" is created
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "topic" is deleted then a "sns" "subscription" confirmation token expires then an endpoint subscribes to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "topic" is deleted
    When a "sns" "subscription" confirmation token expires
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is created then a "sns" "subscription" is removed
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is deleted then a "sns" "message" is published to a "sns" "topic"
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is deleted
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a pending "sns" "subscription" is confirmed then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" is removed then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "message" is published to a "sns" "topic" then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "message" is published to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "delivery" attempt succeeds then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is created
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then all "sns" "delivery" retries are exhausted then a "sns" "topic" is deleted
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" confirmation token expires then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "topic" is created then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is created
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "topic" is deleted then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then an endpoint subscribes to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "subscription" is removed then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" is removed
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" confirmation token expires
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "delivery" attempt succeeds then a "sns" "topic" is created
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is deleted
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then all "sns" "delivery" retries are exhausted then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When all "sns" "delivery" retries are exhausted
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a pending "sns" "subscription" is confirmed then a "sns" "subscription" confirmation token expires then a "sns" "subscription" is removed
    Given sid in sub_status
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" confirmation token expires
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "topic" is created then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "topic" is deleted then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "topic" is deleted
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then an endpoint subscribes to a "sns" "topic" then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When an endpoint subscribes to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a pending "sns" "subscription" is confirmed then a "sns" "subscription" confirmation token expires
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "message" is published to a "sns" "topic" then a "sns" "topic" is created
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "delivery" attempt succeeds then a "sns" "topic" is deleted
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "delivery" attempt fails and is retried then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt fails and is retried
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then all "sns" "delivery" retries are exhausted then a pending "sns" "subscription" is confirmed
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When all "sns" "delivery" retries are exhausted
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" is removed then a "sns" "subscription" confirmation token expires then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" is removed
    When a "sns" "subscription" confirmation token expires
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "topic" is created then a "sns" "delivery" attempt fails and is retried
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "topic" is created
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "topic" is deleted then all "sns" "delivery" retries are exhausted
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "topic" is deleted
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" confirmation token expires
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a pending "sns" "subscription" is confirmed then a "sns" "topic" is created
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" is removed then a "sns" "topic" is deleted
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" is removed
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt succeeds then an endpoint subscribes to a "sns" "topic"
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried then a pending "sns" "subscription" is confirmed
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then all "sns" "delivery" retries are exhausted then a "sns" "subscription" is removed
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt succeeds
    Given tarn in topic_status
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "topic" is created then all "sns" "delivery" retries are exhausted
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is created
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "topic" is deleted then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "topic" is deleted
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is created
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a pending "sns" "subscription" is confirmed then a "sns" "topic" is deleted
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a pending "sns" "subscription" is confirmed
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "subscription" is removed then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "subscription" is removed
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "message" is published to a "sns" "topic" then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "message" is published to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" is removed
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then all "sns" "delivery" retries are exhausted then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When all "sns" "delivery" retries are exhausted
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt succeeds then a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt fails and is retried
    Given did in delivery_status
    When a "sns" "delivery" attempt succeeds
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is created then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is created
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is deleted then a "sns" "topic" is created
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is deleted
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then an endpoint subscribes to a "sns" "topic" then a "sns" "topic" is deleted
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a pending "sns" "subscription" is confirmed then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a pending "sns" "subscription" is confirmed
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" is removed then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" is removed
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "message" is published to a "sns" "topic" then a "sns" "subscription" is removed
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "delivery" attempt succeeds then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "delivery" attempt succeeds
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then all "sns" "delivery" retries are exhausted then a "sns" "delivery" attempt succeeds
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When all "sns" "delivery" retries are exhausted
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" confirmation token expires then all "sns" "delivery" retries are exhausted
    Given did in delivery_status
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" confirmation token expires
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "topic" is created then a "sns" "topic" is deleted
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is created
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "topic" is deleted then an endpoint subscribes to a "sns" "topic"
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is deleted
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then an endpoint subscribes to a "sns" "topic" then a pending "sns" "subscription" is confirmed
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When an endpoint subscribes to a "sns" "topic"
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a pending "sns" "subscription" is confirmed then a "sns" "subscription" is removed
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a pending "sns" "subscription" is confirmed
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "subscription" is removed then a "sns" "message" is published to a "sns" "topic"
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" is removed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt succeeds
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "delivery" attempt succeeds then a "sns" "delivery" attempt fails and is retried
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "delivery" attempt succeeds
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "delivery" attempt fails and is retried then a "sns" "subscription" confirmation token expires
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "subscription" confirmation token expires
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: all "sns" "delivery" retries are exhausted then a "sns" "subscription" confirmation token expires then a "sns" "topic" is created
    Given did in delivery_status
    When all "sns" "delivery" retries are exhausted
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "topic" is created then an endpoint subscribes to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is created
    When an endpoint subscribes to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "topic" is deleted then a pending "sns" "subscription" is confirmed
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "topic" is deleted
    When a pending "sns" "subscription" is confirmed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then an endpoint subscribes to a "sns" "topic" then a "sns" "subscription" is removed
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When an endpoint subscribes to a "sns" "topic"
    When a "sns" "subscription" is removed
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a pending "sns" "subscription" is confirmed then a "sns" "message" is published to a "sns" "topic"
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a pending "sns" "subscription" is confirmed
    When a "sns" "message" is published to a "sns" "topic"
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "subscription" is removed then a "sns" "delivery" attempt succeeds
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "subscription" is removed
    When a "sns" "delivery" attempt succeeds
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "message" is published to a "sns" "topic" then a "sns" "delivery" attempt fails and is retried
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "message" is published to a "sns" "topic"
    When a "sns" "delivery" attempt fails and is retried
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt succeeds then all "sns" "delivery" retries are exhausted
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt succeeds
    When all "sns" "delivery" retries are exhausted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then a "sns" "delivery" attempt fails and is retried then a "sns" "topic" is created
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When a "sns" "delivery" attempt fails and is retried
    When a "sns" "topic" is created
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit

  @sequence
  Scenario: a "sns" "subscription" confirmation token expires then all "sns" "delivery" retries are exhausted then a "sns" "topic" is deleted
    Given sid in sub_status
    When a "sns" "subscription" confirmation token expires
    When all "sns" "delivery" retries are exhausted
    When a "sns" "topic" is deleted
    And no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"
    And no "sns" "delivery" is "IN_FLIGHT" to an unconfirmed "sns" "subscription"
    And every active "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "sns" "delivery" retry count is within the allowed limit
