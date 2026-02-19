Feature: Secrets Manager IAM Authorization

  @iam_auth @secretsmanager @denied
  Scenario Outline: Secrets Manager <operation> is denied in enforce mode
    Given IAM auth was set for "secretsmanager" with mode "enforce" and identity "lws-test-no-perms"
    When I call "secretsmanager" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "secretsmanager"

    Examples:
      | operation                   |
      | list-secrets                |
      | create-secret               |
      | get-secret-value            |
      | put-secret-value            |
      | describe-secret             |
      | update-secret               |
      | delete-secret               |
      | restore-secret              |
      | list-secret-version-ids     |
      | get-resource-policy         |
      | tag-resource                |
      | untag-resource              |

  @iam_auth @secretsmanager @audit
  Scenario Outline: Secrets Manager <operation> passes through in audit mode with a warning
    Given IAM auth was set for "secretsmanager" with mode "audit" and identity "lws-test-no-perms"
    When I call "secretsmanager" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "secretsmanager"

    Examples:
      | operation                   |
      | list-secrets                |
      | create-secret               |
      | get-secret-value            |
      | put-secret-value            |
      | describe-secret             |
      | update-secret               |
      | delete-secret               |
      | restore-secret              |
      | list-secret-version-ids     |
      | get-resource-policy         |
      | tag-resource                |
      | untag-resource              |

  @iam_auth @secretsmanager @pass
  Scenario Outline: Secrets Manager <operation> passes in enforce mode with permissions
    Given IAM auth was set for "secretsmanager" with mode "enforce" and identity "lws-test-full-access"
    When I call "secretsmanager" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "secretsmanager"

    Examples:
      | operation                   |
      | list-secrets                |
      | create-secret               |
      | get-secret-value            |
      | put-secret-value            |
      | describe-secret             |
      | update-secret               |
      | delete-secret               |
      | restore-secret              |
      | list-secret-version-ids     |
      | get-resource-policy         |
      | tag-resource                |
      | untag-resource              |
