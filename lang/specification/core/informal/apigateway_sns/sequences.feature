@apigatewaysns @generated
Feature: ApigatewaySns - Action Sequences

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an "SNS" topic is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "API" Gateway "REST" "API" is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a direct "SNS" integration is configured on the "API"
    Given tid not in topic_status
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API"
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "SNS" topic is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an "SNS" topic is created then a direct "SNS" integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted then an "SNS" topic is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API" then an "SNS" topic is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API"
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API"
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid not in topic_status
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API"
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API"
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid not in topic_status
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API"
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an "API" Gateway "REST" "API" is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a direct "SNS" integration is configured on the "API"
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API" then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API"
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API"
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created then an "SNS" topic is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "SNS" topic is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "SNS" topic is created then the "SNS" topic is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted then an "SNS" topic is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created then an "SNS" topic is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted then an "SNS" topic is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API" then an "SNS" topic is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API" then a request is received but the "SNS" publish fails because the topic has been deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created then an "SNS" topic is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "API" Gateway "REST" "API" is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then an "SNS" topic is created then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When an "SNS" topic is created
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted then an "SNS" topic is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then the "SNS" topic is deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When the "SNS" topic is deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API" then an "SNS" topic is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API" then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a direct "SNS" integration is configured on the "API" then a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a direct "SNS" integration is configured on the "API"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then an "SNS" topic is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When an "SNS" topic is created
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then the "SNS" topic is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When the "SNS" topic is deleted
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted then a request is received, the "API" publishes to the "SNS" topic, and returns 200 then a direct "SNS" integration is configured on the "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the topic has been deleted
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    When a direct "SNS" integration is configured on the "API"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists
