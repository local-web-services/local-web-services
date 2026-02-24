Feature: Cognito IAM Authorization

  @iam_auth @cognito @denied
  Scenario Outline: Cognito <operation> is denied in enforce mode
    Given IAM auth was set for "cognito-idp" with mode "enforce" and identity "lws-test-no-perms"
    When I call "cognito-idp" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "cognito-idp"

    Examples:
      | operation                  |
      | list-user-pools            |
      | create-user-pool           |
      | delete-user-pool           |
      | describe-user-pool         |
      | update-user-pool           |
      | create-user-pool-client    |
      | delete-user-pool-client    |
      | describe-user-pool-client  |
      | list-user-pool-clients     |
      | admin-get-user             |
      | admin-create-user          |
      | admin-delete-user          |
      | list-users                 |
      | sign-up                    |
      | confirm-sign-up            |
      | initiate-auth              |
      | forgot-password            |
      | confirm-forgot-password    |
      | change-password            |
      | global-sign-out            |

  @iam_auth @cognito @audit
  Scenario Outline: Cognito <operation> passes through in audit mode with a warning
    Given IAM auth was set for "cognito-idp" with mode "audit" and identity "lws-test-no-perms"
    When I call "cognito-idp" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "cognito-idp"

    Examples:
      | operation                  |
      | list-user-pools            |
      | create-user-pool           |
      | delete-user-pool           |
      | describe-user-pool         |
      | update-user-pool           |
      | create-user-pool-client    |
      | delete-user-pool-client    |
      | describe-user-pool-client  |
      | list-user-pool-clients     |
      | admin-get-user             |
      | admin-create-user          |
      | admin-delete-user          |
      | list-users                 |
      | sign-up                    |
      | confirm-sign-up            |
      | initiate-auth              |
      | forgot-password            |
      | confirm-forgot-password    |
      | change-password            |
      | global-sign-out            |

  @iam_auth @cognito @pass
  Scenario Outline: Cognito <operation> passes in enforce mode with permissions
    Given IAM auth was set for "cognito-idp" with mode "enforce" and identity "lws-test-full-access"
    When I call "cognito-idp" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "cognito-idp"

    Examples:
      | operation                  |
      | list-user-pools            |
      | create-user-pool           |
      | delete-user-pool           |
      | describe-user-pool         |
      | update-user-pool           |
      | create-user-pool-client    |
      | delete-user-pool-client    |
      | describe-user-pool-client  |
      | list-user-pool-clients     |
      | admin-get-user             |
      | admin-create-user          |
      | admin-delete-user          |
      | list-users                 |
      | sign-up                    |
      | confirm-sign-up            |
      | initiate-auth              |
      | forgot-password            |
      | confirm-forgot-password    |
      | change-password            |
      | global-sign-out            |
