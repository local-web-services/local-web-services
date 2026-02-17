@s3api @get_bucket_notification_configuration @controlplane
Feature: S3 GetBucketNotificationConfiguration

  @happy
  Scenario: Get notification configuration from a bucket
    Given a bucket "e2e-get-notif" was created
    When I get the notification configuration of bucket "e2e-get-notif"
    Then the command will succeed
