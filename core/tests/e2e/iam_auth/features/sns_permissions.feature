Feature: SNS IAM Authorization

  @iam_auth @sns @denied
  Scenario Outline: SNS <operation> is denied in enforce mode
    Given IAM auth was set for "sns" with mode "enforce" and identity "lws-test-no-perms"
    When I call "sns" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "sns"

    Examples:
      | operation                    |
      | list-topics                  |
      | list-subscriptions           |
      | list-subscriptions-by-topic  |
      | create-topic                 |
      | delete-topic                 |
      | publish                      |
      | subscribe                    |
      | unsubscribe                  |
      | get-topic-attributes         |
      | set-topic-attributes         |
      | get-subscription-attributes  |
      | set-subscription-attributes  |
      | confirm-subscription         |
      | list-tags-for-resource       |
      | tag-resource                 |
      | untag-resource               |

  @iam_auth @sns @audit
  Scenario Outline: SNS <operation> passes through in audit mode with a warning
    Given IAM auth was set for "sns" with mode "audit" and identity "lws-test-no-perms"
    When I call "sns" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "sns"

    Examples:
      | operation                    |
      | list-topics                  |
      | list-subscriptions           |
      | list-subscriptions-by-topic  |
      | create-topic                 |
      | delete-topic                 |
      | publish                      |
      | subscribe                    |
      | unsubscribe                  |
      | get-topic-attributes         |
      | set-topic-attributes         |
      | get-subscription-attributes  |
      | set-subscription-attributes  |
      | confirm-subscription         |
      | list-tags-for-resource       |
      | tag-resource                 |
      | untag-resource               |

  @iam_auth @sns @pass
  Scenario Outline: SNS <operation> passes in enforce mode with permissions
    Given IAM auth was set for "sns" with mode "enforce" and identity "lws-test-full-access"
    When I call "sns" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "sns"

    Examples:
      | operation                    |
      | list-topics                  |
      | list-subscriptions           |
      | list-subscriptions-by-topic  |
      | create-topic                 |
      | delete-topic                 |
      | publish                      |
      | subscribe                    |
      | unsubscribe                  |
      | get-topic-attributes         |
      | set-topic-attributes         |
      | get-subscription-attributes  |
      | set-subscription-attributes  |
      | confirm-subscription         |
      | list-tags-for-resource       |
      | tag-resource                 |
      | untag-resource               |
