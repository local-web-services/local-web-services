@sns @set_topic_attributes @controlplane
Feature: SNS SetTopicAttributes

  @happy
  Scenario: Set attributes on a topic
    Given a topic "e2e-set-topic-attrs" was created
    When I set topic attribute "DisplayName" to "E2E Test Topic" for topic "e2e-set-topic-attrs"
    Then the command will succeed
