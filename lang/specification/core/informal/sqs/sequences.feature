@sqs @generated
Feature: Sqs - Action Sequences

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "queue" is deleted
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" is received from the "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then an in-flight "sqs" "message" is deleted
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then "sqs" "message" visibility timeout is changed
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then "sqs" "queue" attributes are retrieved
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" visibility timeout expires
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "queue" is created
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is created
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is deleted
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "queue" is created
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "queue" is deleted
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "queue" is created
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "queue" is deleted
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is created
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is deleted
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "queue" is created
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "queue" is deleted
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "queue" is deleted then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" is received from the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" is received from the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then an in-flight "sqs" "message" is deleted then "sqs" "message" visibility timeout is changed
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When an in-flight "sqs" "message" is deleted
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then "sqs" "message" visibility timeout is changed then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When "sqs" "message" visibility timeout is changed
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "queue" attributes are retrieved
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then "sqs" "queue" attributes are retrieved then a "sqs" "message" visibility timeout expires
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" visibility timeout expires then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is created then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is deleted
    Given qname not in queue_status
    When a "sqs" "queue" is created
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "queue" is created then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" is sent to the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" is received from the "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then an in-flight "sqs" "message" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When an in-flight "sqs" "message" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then "sqs" "message" visibility timeout is changed then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When "sqs" "message" visibility timeout is changed
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then "sqs" "queue" attributes are retrieved then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" visibility timeout expires then a "sqs" "queue" is created
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "queue" is deleted then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "queue" is deleted
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is created then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is created
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is deleted then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is deleted
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then an in-flight "sqs" "message" is deleted then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then "sqs" "message" visibility timeout is changed then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then "sqs" "queue" attributes are retrieved then a "sqs" "queue" is created
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" visibility timeout expires then a "sqs" "queue" is deleted
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is created then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is created
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue" then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then an in-flight "sqs" "message" is deleted then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then "sqs" "message" visibility timeout is changed then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then "sqs" "queue" attributes are retrieved then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" visibility timeout expires then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "queue" is created then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "queue" is created
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "queue" is deleted then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "queue" is deleted
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then "sqs" "message" visibility timeout is changed then a "sqs" "queue" is created
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is deleted
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then "sqs" "queue" attributes are retrieved then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" visibility timeout expires then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: an in-flight "sqs" "message" is deleted then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "queue" is created then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "queue" is created
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "queue" is deleted then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "queue" is deleted
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then an in-flight "sqs" "message" is deleted then a "sqs" "queue" is deleted
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then "sqs" "queue" attributes are retrieved then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" visibility timeout expires then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" visibility timeout expires
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "message" visibility timeout is changed then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is created then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is created
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "queue" is deleted then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "queue" is deleted
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is created
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "queue" is deleted
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then an in-flight "sqs" "message" is deleted then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "message" visibility timeout is changed then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "message" visibility timeout is changed
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "queue" attributes are retrieved then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "queue" attributes are retrieved
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" visibility timeout expires then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" visibility timeout expires
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "queue" attributes are retrieved
    Given qname in queue_status
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "queue" is created then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is created
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "queue" is deleted then a "sqs" "queue" is created
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "queue" is deleted
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" is received from the "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" is received from the "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then an in-flight "sqs" "message" is deleted then a "sqs" "message" is received from the "sqs" "queue"
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When an in-flight "sqs" "message" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then "sqs" "message" visibility timeout is changed then an in-flight "sqs" "message" is deleted
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When "sqs" "message" visibility timeout is changed
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "message" visibility timeout is changed
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" visibility timeout expires then all "sqs" "message"s in a "sqs" "queue" are purged
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" visibility timeout expires
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: "sqs" "queue" attributes are retrieved then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" visibility timeout expires
    Given qname in queue_status
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "queue" is created then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is created
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "queue" is deleted then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" is sent to the "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is sent to the "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" is received from the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" is received from the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then an in-flight "sqs" "message" is deleted then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When an in-flight "sqs" "message" is deleted
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then "sqs" "message" visibility timeout is changed then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When "sqs" "message" visibility timeout is changed
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then all "sqs" "message"s in a "sqs" "queue" are purged then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then "sqs" "queue" attributes are retrieved then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" visibility timeout expires then a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is created then a "sqs" "message" is sent to the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is created
    When a "sqs" "message" is sent to the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "queue" is deleted then a "sqs" "message" is received from the "sqs" "queue"
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "queue" is deleted
    When a "sqs" "message" is received from the "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is sent to the "sqs" "queue" then an in-flight "sqs" "message" is deleted
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is sent to the "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" is received from the "sqs" "queue" then "sqs" "message" visibility timeout is changed
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" is received from the "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then an in-flight "sqs" "message" is deleted then all "sqs" "message"s in a "sqs" "queue" are purged
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When an in-flight "sqs" "message" is deleted
    When all "sqs" "message"s in a "sqs" "queue" are purged
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "message" visibility timeout is changed then "sqs" "queue" attributes are retrieved
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "message" visibility timeout is changed
    When "sqs" "queue" attributes are retrieved
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then all "sqs" "message"s in a "sqs" "queue" are purged then a "sqs" "message" visibility timeout expires
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    When a "sqs" "message" visibility timeout expires
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then "sqs" "queue" attributes are retrieved then a "sqs" "queue" is created
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When "sqs" "queue" attributes are retrieved
    When a "sqs" "queue" is created
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @sequence
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" then a "sqs" "message" visibility timeout expires then a "sqs" "queue" is deleted
    Given mid in msg_status
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    When a "sqs" "message" visibility timeout expires
    When a "sqs" "queue" is deleted
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count
