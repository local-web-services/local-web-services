Feature: SSM IAM Authorization

  @iam_auth @ssm @denied
  Scenario Outline: SSM <operation> is denied in enforce mode
    Given IAM auth was set for "ssm" with mode "enforce" and identity "lws-test-no-perms"
    When I call "ssm" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "ssm"

    Examples:
      | operation                   |
      | describe-parameters         |
      | get-parameter               |
      | get-parameters              |
      | get-parameters-by-path      |
      | put-parameter               |
      | delete-parameter            |
      | delete-parameters           |
      | add-tags-to-resource        |
      | remove-tags-from-resource   |
      | list-tags-for-resource      |

  @iam_auth @ssm @audit
  Scenario Outline: SSM <operation> passes through in audit mode with a warning
    Given IAM auth was set for "ssm" with mode "audit" and identity "lws-test-no-perms"
    When I call "ssm" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "ssm"

    Examples:
      | operation                   |
      | describe-parameters         |
      | get-parameter               |
      | get-parameters              |
      | get-parameters-by-path      |
      | put-parameter               |
      | delete-parameter            |
      | delete-parameters           |
      | add-tags-to-resource        |
      | remove-tags-from-resource   |
      | list-tags-for-resource      |

  @iam_auth @ssm @pass
  Scenario Outline: SSM <operation> passes in enforce mode with permissions
    Given IAM auth was set for "ssm" with mode "enforce" and identity "lws-test-full-access"
    When I call "ssm" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "ssm"

    Examples:
      | operation                   |
      | describe-parameters         |
      | get-parameter               |
      | get-parameters              |
      | get-parameters-by-path      |
      | put-parameter               |
      | delete-parameter            |
      | delete-parameters           |
      | add-tags-to-resource        |
      | remove-tags-from-resource   |
      | list-tags-for-resource      |
