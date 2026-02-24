Feature: DynamoDB IAM Authorization

  @iam_auth @dynamodb @denied
  Scenario Outline: DynamoDB <operation> is denied in enforce mode
    Given IAM auth was set for "dynamodb" with mode "enforce" and identity "lws-test-no-perms"
    When I call "dynamodb" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "dynamodb"

    Examples:
      | operation                    |
      | list-tables                  |
      | create-table                 |
      | delete-table                 |
      | describe-table               |
      | update-table                 |
      | describe-time-to-live        |
      | update-time-to-live          |
      | describe-continuous-backups  |
      | get-item                     |
      | put-item                     |
      | delete-item                  |
      | update-item                  |
      | query                        |
      | scan                         |
      | batch-get-item               |
      | batch-write-item             |
      | transact-get-items           |
      | transact-write-items         |
      | list-tags-of-resource        |
      | tag-resource                 |
      | untag-resource               |

  @iam_auth @dynamodb @audit
  Scenario Outline: DynamoDB <operation> passes through in audit mode with a warning
    Given IAM auth was set for "dynamodb" with mode "audit" and identity "lws-test-no-perms"
    When I call "dynamodb" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "dynamodb"

    Examples:
      | operation                    |
      | list-tables                  |
      | create-table                 |
      | delete-table                 |
      | describe-table               |
      | update-table                 |
      | describe-time-to-live        |
      | update-time-to-live          |
      | describe-continuous-backups  |
      | get-item                     |
      | put-item                     |
      | delete-item                  |
      | update-item                  |
      | query                        |
      | scan                         |
      | batch-get-item               |
      | batch-write-item             |
      | transact-get-items           |
      | transact-write-items         |
      | list-tags-of-resource        |
      | tag-resource                 |
      | untag-resource               |

  @iam_auth @dynamodb @pass
  Scenario Outline: DynamoDB <operation> passes in enforce mode with permissions
    Given IAM auth was set for "dynamodb" with mode "enforce" and identity "lws-test-full-access"
    When I call "dynamodb" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "dynamodb"

    Examples:
      | operation                    |
      | list-tables                  |
      | create-table                 |
      | delete-table                 |
      | describe-table               |
      | update-table                 |
      | describe-time-to-live        |
      | update-time-to-live          |
      | describe-continuous-backups  |
      | get-item                     |
      | put-item                     |
      | delete-item                  |
      | update-item                  |
      | query                        |
      | scan                         |
      | batch-get-item               |
      | batch-write-item             |
      | transact-get-items           |
      | transact-write-items         |
      | list-tags-of-resource        |
      | tag-resource                 |
      | untag-resource               |
