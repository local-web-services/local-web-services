Feature: S3 IAM Authorization

  @iam_auth @s3 @denied
  Scenario Outline: S3 <operation> is denied in enforce mode
    Given IAM auth was set for "s3" with mode "enforce" and identity "lws-test-no-perms"
    When I call "s3" "<operation>"
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "s3"

    Examples:
      | operation                              |
      | list-buckets                           |
      | create-bucket                          |
      | delete-bucket                          |
      | head-bucket                            |
      | list-objects-v2                        |
      | get-bucket-location                    |
      | get-bucket-tagging                     |
      | put-bucket-tagging                     |
      | delete-bucket-tagging                  |
      | get-bucket-policy                      |
      | put-bucket-policy                      |
      | get-bucket-notification-configuration |
      | put-bucket-notification-configuration |
      | get-bucket-website                     |
      | put-bucket-website                     |
      | delete-bucket-website                  |
      | get-object                             |
      | put-object                             |
      | delete-object                          |
      | head-object                            |
      | copy-object                            |
      | delete-objects                         |
      | create-multipart-upload                |
      | upload-part                            |
      | complete-multipart-upload              |
      | abort-multipart-upload                 |
      | list-parts                             |

  @iam_auth @s3 @audit
  Scenario Outline: S3 <operation> passes through in audit mode with a warning
    Given IAM auth was set for "s3" with mode "audit" and identity "lws-test-no-perms"
    When I call "s3" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "s3"

    Examples:
      | operation                              |
      | list-buckets                           |
      | create-bucket                          |
      | delete-bucket                          |
      | head-bucket                            |
      | list-objects-v2                        |
      | get-bucket-location                    |
      | get-bucket-tagging                     |
      | put-bucket-tagging                     |
      | delete-bucket-tagging                  |
      | get-bucket-policy                      |
      | put-bucket-policy                      |
      | get-bucket-notification-configuration |
      | put-bucket-notification-configuration |
      | get-bucket-website                     |
      | put-bucket-website                     |
      | delete-bucket-website                  |
      | get-object                             |
      | put-object                             |
      | delete-object                          |
      | head-object                            |
      | copy-object                            |
      | delete-objects                         |
      | create-multipart-upload                |
      | upload-part                            |
      | complete-multipart-upload              |
      | abort-multipart-upload                 |
      | list-parts                             |

  @iam_auth @s3 @pass
  Scenario Outline: S3 <operation> passes in enforce mode with permissions
    Given IAM auth was set for "s3" with mode "enforce" and identity "lws-test-full-access"
    When I call "s3" "<operation>"
    Then the output will not contain an IAM access denied error
    And IAM auth was cleaned up for "s3"

    Examples:
      | operation                              |
      | list-buckets                           |
      | create-bucket                          |
      | delete-bucket                          |
      | head-bucket                            |
      | list-objects-v2                        |
      | get-bucket-location                    |
      | get-bucket-tagging                     |
      | put-bucket-tagging                     |
      | delete-bucket-tagging                  |
      | get-bucket-policy                      |
      | put-bucket-policy                      |
      | get-bucket-notification-configuration |
      | put-bucket-notification-configuration |
      | get-bucket-website                     |
      | put-bucket-website                     |
      | delete-bucket-website                  |
      | get-object                             |
      | put-object                             |
      | delete-object                          |
      | head-object                            |
      | copy-object                            |
      | delete-objects                         |
      | create-multipart-upload                |
      | upload-part                            |
      | complete-multipart-upload              |
      | abort-multipart-upload                 |
      | list-parts                             |
