@apigatewaysqs @generated
Feature: ApigatewaySqs - Action Sequences

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "sqs" "queue" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then a "SQS" direct integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then an "api gateway" "api" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then a "SQS" direct integration is configured on the "api gateway" "api"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then a "sqs" "queue" is created
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "sqs" "queue" is created
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "SQS" direct integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then an "api gateway" "api" is created
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "SQS" direct integration is configured on the "api gateway" "api"
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then a "sqs" "queue" is created then a "SQS" direct integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "sqs" "queue" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then a "SQS" direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "api gateway" "api" is created then a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "sqs" "queue" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then an "api gateway" "api" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then a "SQS" direct integration is configured on the "api gateway" "api" then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message then an "api gateway" "api" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "sqs" "queue" is created then a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "SQS" direct integration is configured on the "api gateway" "api"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then an "api gateway" "api" is created then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then a "sqs" "queue" is created then an "api gateway" "api" is created
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a "sqs" "queue" is created
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "sqs" "queue" is created
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "SQS" direct integration is configured on the "api gateway" "api" then a backend consumer processes the "sqs" "message" from the "sqs" "queue" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given aid in api_status
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then an "api gateway" "api" is created then a "sqs" "queue" is created
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When an "api gateway" "api" is created
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "sqs" "queue" is created then a "SQS" direct integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "sqs" "queue" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "SQS" direct integration is configured on the "api gateway" "api" then a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a backend consumer processes the "sqs" "message" from the "sqs" "queue" then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then an "api gateway" "api" is created then a "SQS" direct integration is configured on the "api gateway" "api"
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When an "api gateway" "api" is created
    When a "SQS" direct integration is configured on the "api gateway" "api"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "sqs" "queue" is created then the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "sqs" "queue" is created
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then a "SQS" direct integration is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When a "SQS" direct integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the "sqs" "message" from the "sqs" "queue" then the "api gateway" "API" receives a request and enqueues it as a "SQS" message then a "sqs" "queue" is created
    Given mid in msg_status
    When a backend consumer processes the "sqs" "message" from the "sqs" "queue"
    When the "api gateway" "API" receives a request and enqueues it as a "SQS" message
    When a "sqs" "queue" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
