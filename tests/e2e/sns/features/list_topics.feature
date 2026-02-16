@sns @list_topics @controlplane
Feature: SNS ListTopics

  @happy
  Scenario: List topics includes a previously created topic
    Given a topic "e2e-list-topics" was created
    When I list topics
    Then the command will succeed
    And the topic "e2e-list-topics" will appear in the topic list
