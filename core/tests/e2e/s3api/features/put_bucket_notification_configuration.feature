@s3api @put_bucket_notification_configuration @controlplane
Feature: S3 PutBucketNotificationConfiguration

  @happy
  Scenario: Set notification configuration on a bucket
    Given a bucket "e2e-put-notif" was created
    When I put a notification configuration on bucket "e2e-put-notif"
    Then the command will succeed
