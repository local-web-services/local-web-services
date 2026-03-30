@apigatewaysqs @generated
Feature: ApigatewaySqs - Action Sequences

  # Generated from FizzBee spec: apigateway_sqs.fizz
  # Safety invariants: RequestRequiresActiveApi, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "REST" "API" is created then an "SQS" queue is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message
    Given aid not in api_status
    Given a "REST" "API" has been created
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then a backend consumer processes the message from the queue
    Given aid not in api_status
    Given a "REST" "API" has been created
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a "REST" "API" is created
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a backend consumer processes the message from the queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then an "SQS" queue is created
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" direct integration is configured on the "REST" "API"
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then a "REST" "API" is created
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" queue is created
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API"
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given an "SQS" queue has been created
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given the "API" has received a request and enqueued it as an "SQS" message
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a "REST" "API" is created then a backend consumer processes the message from the queue then an "SQS" queue is created
    Given aid not in api_status
    Given a "REST" "API" has been created
    Given a backend consumer has processed the message from the queue
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a "REST" "API" is created then the "API" receives a request and enqueues it as an "SQS" message
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a "REST" "API" has been created
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given the "API" has received a request and enqueued it as an "SQS" message
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" queue is created then a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API"
    Given qid not in queue_status
    Given an "SQS" queue has been created
    Given a backend consumer has processed the message from the queue
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created then a backend consumer processes the message from the queue
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    Given a "REST" "API" has been created
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then an "SQS" queue is created then a "REST" "API" is created
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    Given an "SQS" queue has been created
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    Given the "API" has received a request and enqueued it as an "SQS" message
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message
    Given aid in api_status
    Given an "SQS" direct integration has been configured on the "REST" "API"
    Given a backend consumer has processed the message from the queue
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a "REST" "API" is created then an "SQS" queue is created
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    Given a "REST" "API" has been created
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created then an "SQS" direct integration is configured on the "REST" "API"
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    Given an "SQS" queue has been created
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then an "SQS" direct integration is configured on the "REST" "API" then a backend consumer processes the message from the queue
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When a backend consumer processes the message from the queue
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: the "API" receives a request and enqueues it as an "SQS" message then a backend consumer processes the message from the queue then a "REST" "API" is created
    Given aid in api_status
    Given the "API" has received a request and enqueued it as an "SQS" message
    Given a backend consumer has processed the message from the queue
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then a "REST" "API" is created then an "SQS" direct integration is configured on the "REST" "API"
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    Given a "REST" "API" has been created
    When an "SQS" direct integration is configured on the "REST" "API"
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" queue is created then the "API" receives a request and enqueues it as an "SQS" message
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    Given an "SQS" queue has been created
    When the "API" receives a request and enqueues it as an "SQS" message
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then an "SQS" direct integration is configured on the "REST" "API" then a "REST" "API" is created
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    Given an "SQS" direct integration has been configured on the "REST" "API"
    When a "REST" "API" is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @sequence
  Scenario: a backend consumer processes the message from the queue then the "API" receives a request and enqueues it as an "SQS" message then an "SQS" queue is created
    Given mid in msg_status
    Given a backend consumer has processed the message from the queue
    Given the "API" has received a request and enqueued it as an "SQS" message
    When an "SQS" queue is created
    Then every "ACCEPTED" request references an "ACTIVE" "API"
    And every "AVAILABLE" message belongs to an "ACTIVE" queue
