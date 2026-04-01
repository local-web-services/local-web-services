@apigatewaysns @generated
Feature: ApigatewaySns - Action Sequences

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "sns" "topic" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then the "sns" "topic" is deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "api gateway" "api" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a direct "SNS" integration is configured on the "api gateway" "API"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "api gateway" "api" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a direct "SNS" integration is configured on the "api gateway" "API"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a "sns" "topic" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then the "sns" "topic" is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a "sns" "topic" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then the "sns" "topic" is deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then the "sns" "topic" is deleted then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "sns" "topic" is deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct "SNS" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "api gateway" "api" is created then a direct "SNS" integration is configured on the "api gateway" "API"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "api gateway" "api" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a direct "SNS" integration is configured on the "api gateway" "API" then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then an "api gateway" "api" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "api gateway" "api" is created then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a direct "SNS" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a direct "SNS" integration is configured on the "api gateway" "API"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a "sns" "topic" is created then an "api gateway" "api" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a "sns" "topic" is created
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then the "sns" "topic" is deleted then a "sns" "topic" is created
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then the "sns" "topic" is deleted
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid in api_status
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then an "api gateway" "api" is created then a "sns" "topic" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When an "api gateway" "api" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then the "sns" "topic" is deleted then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When the "sns" "topic" is deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a direct "SNS" integration is configured on the "api gateway" "API" then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then an "api gateway" "api" is created then the "sns" "topic" is deleted
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When an "api gateway" "api" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a "sns" "topic" is created then a direct "SNS" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    When a direct "SNS" integration is configured on the "api gateway" "API"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a direct "SNS" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a direct "SNS" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted then a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 then a "sns" "topic" is created
    Given aid in api_status
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    When a "sns" "topic" is created
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists
