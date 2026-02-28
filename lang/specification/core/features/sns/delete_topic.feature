@sns @delete_topic @controlplane
Feature: SNS DeleteTopic

  @happy
  Scenario: Delete an existing topic
    Given a topic "e2e-del-topic" was created
    When I delete the topic "e2e-del-topic"
    Then the command will succeed
    And the topic "e2e-del-topic" will not appear in the topic list
