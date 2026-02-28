@sns @create_topic @controlplane
Feature: SNS CreateTopic

  @happy
  Scenario: Create a new topic
    When I create topic "e2e-create-topic"
    Then the command will succeed
    And the topic "e2e-create-topic" will appear in the topic list
