"""Unit tests: bucket_has_eventbridge_notification calls put_bucket_notification_configuration."""

from __future__ import annotations

from unittest.mock import MagicMock

from tests.e2e.s3api_events.constants import TEST_BUCKET
from tests.e2e.s3api_events.given.bucket_has_eventbridge_notification import (
    bucket_has_eventbridge_notification,
)


class TestBucketHasEventbridgeNotificationConfiguresS3:
    """bucket_has_eventbridge_notification configures the bucket for EventBridge."""

    def test_calls_put_bucket_notification_configuration(self) -> None:
        # Arrange
        mock_s3 = MagicMock()
        mock_session = MagicMock()
        mock_session.client.return_value = mock_s3
        expected_bucket = TEST_BUCKET
        expected_notification_config = {"EventBridgeConfiguration": {}}

        # Act
        bucket_has_eventbridge_notification(mock_session)

        # Assert
        mock_s3.put_bucket_notification_configuration.assert_called_once_with(
            Bucket=expected_bucket,
            NotificationConfiguration=expected_notification_config,
        )

    def test_uses_s3_client(self) -> None:
        # Arrange
        mock_s3 = MagicMock()
        mock_session = MagicMock()
        mock_session.client.return_value = mock_s3
        expected_service = "s3"

        # Act
        bucket_has_eventbridge_notification(mock_session)

        # Assert
        actual_calls = [call[0][0] for call in mock_session.client.call_args_list]
        assert expected_service in actual_calls, (
            f"Expected session.client('{expected_service}') to be called "
            f"but calls were: {actual_calls}"
        )
