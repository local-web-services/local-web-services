@sns @publish @dataplane
Feature: SNS Publish

  @happy
  Scenario: Publish a message to a topic
    Given a topic "e2e-publish-topic" was created
    When I publish message "hello from e2e" to topic "e2e-publish-topic"
    Then the command will succeed
    And the output will contain a PublishResponse
