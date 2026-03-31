@glaciersns @generated
Feature: GlacierSns - The "Sns" "Topic" Is Deleted

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @delete_topic
  Scenario: the "sns" "topic" is deleted
    Given the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    When the "sns" "topic" is deleted
    Then the "sns" "topic" will be deleted and Glacier notifications will fail
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @delete_topic
  Scenario: the "sns" "topic" is deleted fails when the "sns" "topic" did not exist
    Given the "sns" "topic" did not exist
    When the "sns" "topic" is deleted
    Then the operation is rejected

  @guard @negative @delete_topic @lifecycle
  Scenario: the "sns" "topic" is deleted fails when the "sns" "topic" is already "DELETED"
    Given the "sns" "topic" existed
    And the "sns" "topic" is already "DELETED"
    When the "sns" "topic" is deleted
    Then the operation is rejected
