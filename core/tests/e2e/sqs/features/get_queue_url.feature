@sqs @get_queue_url @controlplane
Feature: SQS GetQueueUrl

  @happy
  Scenario: Get the URL of a queue
    Given a queue "e2e-get-queue-url" was created
    When I get the queue URL for "e2e-get-queue-url"
    Then the command will succeed
