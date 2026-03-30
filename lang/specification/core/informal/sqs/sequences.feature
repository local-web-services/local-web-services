@sqs @generated
Feature: Sqs - Action Sequences

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @sequence
  Scenario: a queue is created then a queue is deleted
    Given qname not in queue_status
    Given a queue has been created
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message is sent to the queue
    Given qname not in queue_status
    Given a queue has been created
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message is received from the queue
    Given qname not in queue_status
    Given a queue has been created
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then an in-flight message is deleted
    Given qname not in queue_status
    Given a queue has been created
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then message visibility timeout is changed
    Given qname not in queue_status
    Given a queue has been created
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then all messages in a queue are purged
    Given qname not in queue_status
    Given a queue has been created
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then queue attributes are retrieved
    Given qname not in queue_status
    Given a queue has been created
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message visibility timeout expires
    Given qname not in queue_status
    Given a queue has been created
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    Given a queue has been created
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a queue is created
    Given qname in queue_status
    Given a queue has been deleted
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message is sent to the queue
    Given qname in queue_status
    Given a queue has been deleted
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message is received from the queue
    Given qname in queue_status
    Given a queue has been deleted
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then an in-flight message is deleted
    Given qname in queue_status
    Given a queue has been deleted
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    Given a queue has been deleted
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then all messages in a queue are purged
    Given qname in queue_status
    Given a queue has been deleted
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then queue attributes are retrieved
    Given qname in queue_status
    Given a queue has been deleted
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message visibility timeout expires
    Given qname in queue_status
    Given a queue has been deleted
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given a queue has been deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a queue is created
    Given qname in queue_status
    Given a message has been sent to the queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a queue is deleted
    Given qname in queue_status
    Given a message has been sent to the queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message is received from the queue
    Given qname in queue_status
    Given a message has been sent to the queue
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    Given a message has been sent to the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed
    Given qname in queue_status
    Given a message has been sent to the queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged
    Given qname in queue_status
    Given a message has been sent to the queue
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved
    Given qname in queue_status
    Given a message has been sent to the queue
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires
    Given qname in queue_status
    Given a message has been sent to the queue
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given a message has been sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a queue is created
    Given mid in msg_status
    Given a message has been received from the queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a queue is deleted
    Given mid in msg_status
    Given a message has been received from the queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message is sent to the queue
    Given mid in msg_status
    Given a message has been received from the queue
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    Given a message has been received from the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    Given a message has been received from the queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged
    Given mid in msg_status
    Given a message has been received from the queue
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved
    Given mid in msg_status
    Given a message has been received from the queue
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires
    Given mid in msg_status
    Given a message has been received from the queue
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given a message has been received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a queue is created
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    Given an in-flight message has been deleted
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    Given an in-flight message has been deleted
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved
    Given mid in msg_status
    Given an in-flight message has been deleted
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a queue is created
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a queue is deleted
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted
    Given mid in msg_status
    Given message visibility timeout has been changed
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    Given message visibility timeout has been changed
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    Given message visibility timeout has been changed
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a queue is created
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a queue is deleted
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted
    Given qname in queue_status
    Given all messages in a queue have been purged
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    Given all messages in a queue have been purged
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved
    Given qname in queue_status
    Given all messages in a queue have been purged
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a queue is created
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a queue is deleted
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    Given queue attributes have been retrieved
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed
    Given qname in queue_status
    Given queue attributes have been retrieved
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged
    Given qname in queue_status
    Given queue attributes have been retrieved
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a queue is created
    Given mid in msg_status
    Given a message visibility timeout has expired
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    Given a message visibility timeout has expired
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    Given a message visibility timeout has expired
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed
    Given mid in msg_status
    Given a message visibility timeout has expired
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged
    Given mid in msg_status
    Given a message visibility timeout has expired
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved
    Given mid in msg_status
    Given a message visibility timeout has expired
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a queue is deleted then a message is sent to the queue
    Given qname not in queue_status
    Given a queue has been created
    Given a queue has been deleted
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message is sent to the queue then a message is received from the queue
    Given qname not in queue_status
    Given a queue has been created
    Given a message has been sent to the queue
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message is received from the queue then an in-flight message is deleted
    Given qname not in queue_status
    Given a queue has been created
    Given a message has been received from the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then an in-flight message is deleted then message visibility timeout is changed
    Given qname not in queue_status
    Given a queue has been created
    Given an in-flight message has been deleted
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then message visibility timeout is changed then all messages in a queue are purged
    Given qname not in queue_status
    Given a queue has been created
    Given message visibility timeout has been changed
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then all messages in a queue are purged then queue attributes are retrieved
    Given qname not in queue_status
    Given a queue has been created
    Given all messages in a queue have been purged
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then queue attributes are retrieved then a message visibility timeout expires
    Given qname not in queue_status
    Given a queue has been created
    Given queue attributes have been retrieved
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue
    Given qname not in queue_status
    Given a queue has been created
    Given a message visibility timeout has expired
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is created then a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted
    Given qname not in queue_status
    Given a queue has been created
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a queue is created then a message is received from the queue
    Given qname in queue_status
    Given a queue has been deleted
    Given a queue has been created
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message is sent to the queue then an in-flight message is deleted
    Given qname in queue_status
    Given a queue has been deleted
    Given a message has been sent to the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message is received from the queue then message visibility timeout is changed
    Given qname in queue_status
    Given a queue has been deleted
    Given a message has been received from the queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then an in-flight message is deleted then all messages in a queue are purged
    Given qname in queue_status
    Given a queue has been deleted
    Given an in-flight message has been deleted
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then message visibility timeout is changed then queue attributes are retrieved
    Given qname in queue_status
    Given a queue has been deleted
    Given message visibility timeout has been changed
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then all messages in a queue are purged then a message visibility timeout expires
    Given qname in queue_status
    Given a queue has been deleted
    Given all messages in a queue have been purged
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given a queue has been deleted
    Given queue attributes have been retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message visibility timeout expires then a queue is created
    Given qname in queue_status
    Given a queue has been deleted
    Given a message visibility timeout has expired
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue
    Given qname in queue_status
    Given a queue has been deleted
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a queue is created then an in-flight message is deleted
    Given qname in queue_status
    Given a message has been sent to the queue
    Given a queue has been created
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a queue is deleted then message visibility timeout is changed
    Given qname in queue_status
    Given a message has been sent to the queue
    Given a queue has been deleted
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message is received from the queue then all messages in a queue are purged
    Given qname in queue_status
    Given a message has been sent to the queue
    Given a message has been received from the queue
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then an in-flight message is deleted then queue attributes are retrieved
    Given qname in queue_status
    Given a message has been sent to the queue
    Given an in-flight message has been deleted
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then message visibility timeout is changed then a message visibility timeout expires
    Given qname in queue_status
    Given a message has been sent to the queue
    Given message visibility timeout has been changed
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given a message has been sent to the queue
    Given all messages in a queue have been purged
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then queue attributes are retrieved then a queue is created
    Given qname in queue_status
    Given a message has been sent to the queue
    Given queue attributes have been retrieved
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message visibility timeout expires then a queue is deleted
    Given qname in queue_status
    Given a message has been sent to the queue
    Given a message visibility timeout has expired
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue
    Given qname in queue_status
    Given a message has been sent to the queue
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a queue is created then message visibility timeout is changed
    Given mid in msg_status
    Given a message has been received from the queue
    Given a queue has been created
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a queue is deleted then all messages in a queue are purged
    Given mid in msg_status
    Given a message has been received from the queue
    Given a queue has been deleted
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message is sent to the queue then queue attributes are retrieved
    Given mid in msg_status
    Given a message has been received from the queue
    Given a message has been sent to the queue
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then an in-flight message is deleted then a message visibility timeout expires
    Given mid in msg_status
    Given a message has been received from the queue
    Given an in-flight message has been deleted
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given a message has been received from the queue
    Given message visibility timeout has been changed
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then all messages in a queue are purged then a queue is created
    Given mid in msg_status
    Given a message has been received from the queue
    Given all messages in a queue have been purged
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then queue attributes are retrieved then a queue is deleted
    Given mid in msg_status
    Given a message has been received from the queue
    Given queue attributes have been retrieved
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message visibility timeout expires then a message is sent to the queue
    Given mid in msg_status
    Given a message has been received from the queue
    Given a message visibility timeout has expired
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted
    Given mid in msg_status
    Given a message has been received from the queue
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a queue is created then all messages in a queue are purged
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a queue has been created
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a queue is deleted then queue attributes are retrieved
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a queue has been deleted
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message is sent to the queue then a message visibility timeout expires
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a message has been sent to the queue
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message is received from the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a message has been received from the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then message visibility timeout is changed then a queue is created
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given message visibility timeout has been changed
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then all messages in a queue are purged then a queue is deleted
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given all messages in a queue have been purged
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then queue attributes are retrieved then a message is sent to the queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given queue attributes have been retrieved
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message visibility timeout expires then a message is received from the queue
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a message visibility timeout has expired
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: an in-flight message is deleted then a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed
    Given mid in msg_status
    Given an in-flight message has been deleted
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a queue is created then queue attributes are retrieved
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a queue has been created
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a queue is deleted then a message visibility timeout expires
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a queue has been deleted
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message is sent to the queue then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a message has been sent to the queue
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message is received from the queue then a queue is created
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a message has been received from the queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then an in-flight message is deleted then a queue is deleted
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given an in-flight message has been deleted
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then all messages in a queue are purged then a message is sent to the queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given all messages in a queue have been purged
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then queue attributes are retrieved then a message is received from the queue
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given queue attributes have been retrieved
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message visibility timeout expires then an in-flight message is deleted
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a message visibility timeout has expired
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: message visibility timeout is changed then a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged
    Given mid in msg_status
    Given message visibility timeout has been changed
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a queue is created then a message visibility timeout expires
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a queue has been created
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a queue is deleted then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a queue has been deleted
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message is sent to the queue then a queue is created
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a message has been sent to the queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message is received from the queue then a queue is deleted
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a message has been received from the queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then an in-flight message is deleted then a message is sent to the queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given an in-flight message has been deleted
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then message visibility timeout is changed then a message is received from the queue
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given message visibility timeout has been changed
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then queue attributes are retrieved then an in-flight message is deleted
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given queue attributes have been retrieved
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message visibility timeout expires then message visibility timeout is changed
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a message visibility timeout has expired
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: all messages in a queue are purged then a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved
    Given qname in queue_status
    Given all messages in a queue have been purged
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a queue is created then a message exceeding its receive count is moved to the dead-letter queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a queue has been created
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a queue is deleted then a queue is created
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a queue has been deleted
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message is sent to the queue then a queue is deleted
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a message has been sent to the queue
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message is received from the queue then a message is sent to the queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a message has been received from the queue
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then an in-flight message is deleted then a message is received from the queue
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given an in-flight message has been deleted
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then message visibility timeout is changed then an in-flight message is deleted
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given message visibility timeout has been changed
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then all messages in a queue are purged then message visibility timeout is changed
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given all messages in a queue have been purged
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message visibility timeout expires then all messages in a queue are purged
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a message visibility timeout has expired
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires
    Given qname in queue_status
    Given queue attributes have been retrieved
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a queue is created then a queue is deleted
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given a queue has been created
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a queue is deleted then a message is sent to the queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given a queue has been deleted
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message is sent to the queue then a message is received from the queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given a message has been sent to the queue
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message is received from the queue then an in-flight message is deleted
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given a message has been received from the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then an in-flight message is deleted then message visibility timeout is changed
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given an in-flight message has been deleted
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then message visibility timeout is changed then all messages in a queue are purged
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given message visibility timeout has been changed
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then all messages in a queue are purged then queue attributes are retrieved
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given all messages in a queue have been purged
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then queue attributes are retrieved then a message exceeding its receive count is moved to the dead-letter queue
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given queue attributes have been retrieved
    When a message exceeding its receive count is moved to the dead-letter queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message visibility timeout expires then a message exceeding its receive count is moved to the dead-letter queue then a queue is created
    Given mid in msg_status
    Given a message visibility timeout has expired
    Given a message exceeding its receive count has been moved to the dead-letter queue
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is created then a message is sent to the queue
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given a queue has been created
    When a message is sent to the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a queue is deleted then a message is received from the queue
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given a queue has been deleted
    When a message is received from the queue
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is sent to the queue then an in-flight message is deleted
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given a message has been sent to the queue
    When an in-flight message is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message is received from the queue then message visibility timeout is changed
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given a message has been received from the queue
    When message visibility timeout is changed
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then an in-flight message is deleted then all messages in a queue are purged
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given an in-flight message has been deleted
    When all messages in a queue are purged
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then message visibility timeout is changed then queue attributes are retrieved
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given message visibility timeout has been changed
    When queue attributes are retrieved
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then all messages in a queue are purged then a message visibility timeout expires
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given all messages in a queue have been purged
    When a message visibility timeout expires
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then queue attributes are retrieved then a queue is created
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given queue attributes have been retrieved
    When a queue is created
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @sequence
  Scenario: a message exceeding its receive count is moved to the dead-letter queue then a message visibility timeout expires then a queue is deleted
    Given mid in msg_status
    Given a message exceeding its receive count has been moved to the dead-letter queue
    Given a message visibility timeout has expired
    When a queue is deleted
    Then every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count
