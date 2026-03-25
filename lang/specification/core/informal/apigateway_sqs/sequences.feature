@apigatewaysqs @generated
Feature: ApigatewaySqs - Action Sequences

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then an "SQS" queue is created
    Given aid not in api_status
    When a "REST" "API" is created
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a backend consumer processes the message from the queue
    Given aid not in api_status
    When a "REST" "API" is created
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a "REST" "API" is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a backend consumer processes the message from the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then an "SQS" queue is created
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" direct integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then a "REST" "API" is created
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" queue is created
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API"
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When an "SQS" queue is created
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message
    Given aid not in api_status
    When a "REST" "API" is created
    When an "SQS" direct integration is configured on the "REST" "API"
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives a request and enqueues it as an "SQS" message
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a backend consumer processes the message from the queue then an "SQS" queue is created
    Given aid not in api_status
    When a "REST" "API" is created
    When a backend consumer processes the message from the queue
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message
    Given qid not in queue_status
    When an "SQS" queue is created
    When a "REST" "API" is created
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" direct integration is configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "API" receives a request and enqueues it as an "SQS" message
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API"
    Given qid not in queue_status
    When an "SQS" queue is created
    When a backend consumer processes the message from the queue
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created then a backend consumer processes the message from the queue
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then an "SQS" queue is created then a "REST" "API" is created
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When an "SQS" queue is created
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message
    Given aid in api_status
    When an "SQS" direct integration is configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created then an "SQS" queue is created
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When a "REST" "API" is created
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" queue is created
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" direct integration is configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives a request and enqueues it as an "SQS" message
    When a backend consumer processes the message from the queue
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API"
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When a "REST" "API" is created
    When an "SQS" direct integration is configured on the "REST" "API"
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When an "SQS" queue is created
    When the "API" receives a request and enqueues it as an "SQS" message
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When an "SQS" direct integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @exhaustive @sequence
  Scenario: a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given mid in msg_status
    When a backend consumer processes the message from the queue
    When the "API" receives a request and enqueues it as an "SQS" message
    When an "SQS" queue is created
    And every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
