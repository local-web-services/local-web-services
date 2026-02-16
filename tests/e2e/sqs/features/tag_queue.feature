@sqs @tag_queue @controlplane
Feature: SQS TagQueue

  @happy
  Scenario: Tag a queue
    Given a queue "e2e-tag-q" was created
    When I tag queue "e2e-tag-q" with tags '{"env":"test"}'
    Then the command will succeed
