@sqs @generated
Feature: Sqs - Action Sequences

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    When a queue is created
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname not in queue_status
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a queue is deleted
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname in queue_status
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname in queue_status
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message is received from the queue
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given mid in msg_status
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given mid in msg_status
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given mid in msg_status
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname in queue_status
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname in queue_status
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is created
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a queue is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message is received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When an in-flight message is deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When message visibility timeout is changed
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When all messages in a queue are purged
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    When a message visibility timeout expires
    When queue attributes are retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    When a message visibility timeout expires
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is created
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a queue is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is sent to the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message is received from the queue
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When an in-flight message is deleted
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When message visibility timeout is changed
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When all messages in a queue are purged
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a message visibility timeout expires
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When queue attributes are retrieved
    When a message visibility timeout expires
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then a queue is created
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When a queue is created
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When a queue is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When a message is sent to the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When a message is received from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When an in-flight message is deleted
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then message visibility timeout is changed
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When message visibility timeout is changed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When all messages in a queue are purged
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @exhaustive @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    When a message exceeding its receive count is moved to the dead-letter queue
    When a message visibility timeout expires
    When queue attributes are retrieved
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count
