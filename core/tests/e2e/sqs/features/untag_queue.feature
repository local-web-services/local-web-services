@sqs @untag_queue @controlplane
Feature: SQS UntagQueue

  @happy
  Scenario: Untag a queue
    Given a queue "e2e-untag-q" was created
    And queue "e2e-untag-q" was tagged with '{"env":"test"}'
    When I untag queue "e2e-untag-q" with tag keys '["env"]'
    Then the command will succeed
    And queue "e2e-untag-q" will not have tag "env"
