Feature: EventBridge IAM Authorization

  @iam_auth @events @denied
  Scenario Outline: EventBridge <operation> is denied in enforce mode
    Given IAM auth was set for "events" with mode "enforce" and identity "lws-test-no-perms"
    When I call "events" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "events"

    Examples:
      | operation               |
      | list-rules              |
      | list-event-buses        |
      | describe-event-bus      |
      | create-event-bus        |
      | delete-event-bus        |
      | put-rule                |
      | delete-rule             |
      | describe-rule           |
      | put-targets             |
      | remove-targets          |
      | list-targets-by-rule    |
      | enable-rule             |
      | disable-rule            |
      | put-events              |
      | list-tags-for-resource  |
      | tag-resource            |
      | untag-resource          |

  @iam_auth @events @audit
  Scenario Outline: EventBridge <operation> passes through in audit mode with a warning
    Given IAM auth was set for "events" with mode "audit" and identity "lws-test-no-perms"
    When I call "events" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "events"

    Examples:
      | operation               |
      | list-rules              |
      | list-event-buses        |
      | describe-event-bus      |
      | create-event-bus        |
      | delete-event-bus        |
      | put-rule                |
      | delete-rule             |
      | describe-rule           |
      | put-targets             |
      | remove-targets          |
      | list-targets-by-rule    |
      | enable-rule             |
      | disable-rule            |
      | put-events              |
      | list-tags-for-resource  |
      | tag-resource            |
      | untag-resource          |

  @iam_auth @events @pass
  Scenario Outline: EventBridge <operation> passes in enforce mode with permissions
    Given IAM auth was set for "events" with mode "enforce" and identity "lws-test-full-access"
    When I call "events" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "events"

    Examples:
      | operation               |
      | list-rules              |
      | list-event-buses        |
      | describe-event-bus      |
      | create-event-bus        |
      | delete-event-bus        |
      | put-rule                |
      | delete-rule             |
      | describe-rule           |
      | put-targets             |
      | remove-targets          |
      | list-targets-by-rule    |
      | enable-rule             |
      | disable-rule            |
      | put-events              |
      | list-tags-for-resource  |
      | tag-resource            |
      | untag-resource          |
