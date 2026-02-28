@sns @get_topic_attributes @controlplane
Feature: SNS GetTopicAttributes

  @happy
  Scenario: Get attributes of a topic
    Given a topic "e2e-get-topic-attrs" was created
    When I get topic attributes for topic "e2e-get-topic-attrs"
    Then the command will succeed
