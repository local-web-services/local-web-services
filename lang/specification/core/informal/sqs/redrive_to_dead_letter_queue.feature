@sqs @generated
Feature: Sqs - A "Sqs" "Message" Exceeding Its Receive Count Is Moved To The Dead-Letter "Sqs" "Queue"

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "queue" had a maximum receive count configured
    And the "sqs" "message" had exceeded the maximum receive count
    And the dead-letter "sqs" "queue" existed
    And the dead-letter "sqs" "queue" was "ACTIVE"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the "sqs" "message" will be "AVAILABLE" in the dead-letter "sqs" "queue"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the "sqs" "message" did not exist
    Given the "sqs" "message" did not exist
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the "sqs" "message" was not "AVAILABLE"
    Given the "sqs" "message" existed
    And the "sqs" "message" was not "AVAILABLE"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the "sqs" "message"'s "sqs" "queue" did not exist
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" did not exist
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the "sqs" "queue" did not have a maximum receive count configured
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "queue" did not have a maximum receive count configured
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the "sqs" "message" had not exceeded the maximum receive count
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "queue" had a maximum receive count configured
    And the "sqs" "message" had not exceeded the maximum receive count
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the dead-letter "sqs" "queue" did not exist
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "queue" had a maximum receive count configured
    And the "sqs" "message" had exceeded the maximum receive count
    And the dead-letter "sqs" "queue" did not exist
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected

  @guard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue" fails when the dead-letter "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "queue" had a maximum receive count configured
    And the "sqs" "message" had exceeded the maximum receive count
    And the dead-letter "sqs" "queue" existed
    And the dead-letter "sqs" "queue" was not "ACTIVE"
    When a "sqs" "message" exceeding its receive count is moved to the dead-letter "sqs" "queue"
    Then the operation is rejected
