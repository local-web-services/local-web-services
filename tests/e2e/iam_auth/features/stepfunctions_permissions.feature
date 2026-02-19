Feature: Step Functions IAM Authorization

  @iam_auth @stepfunctions @denied
  Scenario Outline: Step Functions <operation> is denied in enforce mode
    Given IAM auth was set for "stepfunctions" with mode "enforce" and identity "lws-test-no-perms"
    When I call "stepfunctions" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "stepfunctions"

    Examples:
      | operation                          |
      | list-state-machines                |
      | create-state-machine               |
      | delete-state-machine               |
      | describe-state-machine             |
      | update-state-machine               |
      | validate-state-machine-definition  |
      | list-state-machine-versions        |
      | start-execution                    |
      | start-sync-execution               |
      | stop-execution                     |
      | describe-execution                 |
      | list-executions                    |
      | get-execution-history              |
      | list-tags-for-resource             |
      | tag-resource                       |
      | untag-resource                     |

  @iam_auth @stepfunctions @audit
  Scenario Outline: Step Functions <operation> passes through in audit mode with a warning
    Given IAM auth was set for "stepfunctions" with mode "audit" and identity "lws-test-no-perms"
    When I call "stepfunctions" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "stepfunctions"

    Examples:
      | operation                          |
      | list-state-machines                |
      | create-state-machine               |
      | delete-state-machine               |
      | describe-state-machine             |
      | update-state-machine               |
      | validate-state-machine-definition  |
      | list-state-machine-versions        |
      | start-execution                    |
      | start-sync-execution               |
      | stop-execution                     |
      | describe-execution                 |
      | list-executions                    |
      | get-execution-history              |
      | list-tags-for-resource             |
      | tag-resource                       |
      | untag-resource                     |

  @iam_auth @stepfunctions @pass
  Scenario Outline: Step Functions <operation> passes in enforce mode with permissions
    Given IAM auth was set for "stepfunctions" with mode "enforce" and identity "lws-test-full-access"
    When I call "stepfunctions" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "stepfunctions"

    Examples:
      | operation                          |
      | list-state-machines                |
      | create-state-machine               |
      | delete-state-machine               |
      | describe-state-machine             |
      | update-state-machine               |
      | validate-state-machine-definition  |
      | list-state-machine-versions        |
      | start-execution                    |
      | start-sync-execution               |
      | stop-execution                     |
      | describe-execution                 |
      | list-executions                    |
      | get-execution-history              |
      | list-tags-for-resource             |
      | tag-resource                       |
      | untag-resource                     |
