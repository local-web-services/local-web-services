Feature: SQS IAM Authorization

  @iam_auth @sqs @denied
  Scenario Outline: SQS <operation> is denied in enforce mode
    Given IAM auth was set for "sqs" with mode "enforce" and identity "lws-test-no-perms"
    When I call "sqs" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "sqs"

    Examples:
      | operation                          |
      | list-queues                        |
      | create-queue                       |
      | delete-queue                       |
      | get-queue-url                      |
      | get-queue-attributes               |
      | set-queue-attributes               |
      | purge-queue                        |
      | list-queue-tags                    |
      | tag-queue                          |
      | untag-queue                        |
      | send-message                       |
      | send-message-batch                 |
      | receive-message                    |
      | delete-message                     |
      | delete-message-batch               |
      | change-message-visibility          |
      | change-message-visibility-batch    |
      | list-dead-letter-source-queues     |

  @iam_auth @sqs @audit
  Scenario Outline: SQS <operation> passes through in audit mode with a warning
    Given IAM auth was set for "sqs" with mode "audit" and identity "lws-test-no-perms"
    When I call "sqs" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "sqs"

    Examples:
      | operation                          |
      | list-queues                        |
      | create-queue                       |
      | delete-queue                       |
      | get-queue-url                      |
      | get-queue-attributes               |
      | set-queue-attributes               |
      | purge-queue                        |
      | list-queue-tags                    |
      | tag-queue                          |
      | untag-queue                        |
      | send-message                       |
      | send-message-batch                 |
      | receive-message                    |
      | delete-message                     |
      | delete-message-batch               |
      | change-message-visibility          |
      | change-message-visibility-batch    |
      | list-dead-letter-source-queues     |

  @iam_auth @sqs @pass
  Scenario Outline: SQS <operation> passes in enforce mode with permissions
    Given IAM auth was set for "sqs" with mode "enforce" and identity "lws-test-full-access"
    When I call "sqs" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "sqs"

    Examples:
      | operation                          |
      | list-queues                        |
      | create-queue                       |
      | delete-queue                       |
      | get-queue-url                      |
      | get-queue-attributes               |
      | set-queue-attributes               |
      | purge-queue                        |
      | list-queue-tags                    |
      | tag-queue                          |
      | untag-queue                        |
      | send-message                       |
      | send-message-batch                 |
      | receive-message                    |
      | delete-message                     |
      | delete-message-batch               |
      | change-message-visibility          |
      | change-message-visibility-batch    |
      | list-dead-letter-source-queues     |
