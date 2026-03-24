"""Unit tests for Lambda ARN validation in _validate_notification_targets."""

from __future__ import annotations

from unittest.mock import MagicMock

from lws.providers.s3._s3_bucket_ops import _validate_notification_targets

_LAMBDA_ARN = "arn:aws:lambda:us-east-1:000000000000:function:my-func"
_LAMBDA_NOTIFICATION_XML = (
    '<?xml version="1.0" encoding="UTF-8"?>'
    "<NotificationConfiguration>"
    "<CloudFunctionConfiguration>"
    f"<CloudFunction>{_LAMBDA_ARN}</CloudFunction>"
    "<Event>s3:ObjectCreated:*</Event>"
    "</CloudFunctionConfiguration>"
    "</NotificationConfiguration>"
)
_EMPTY_NOTIFICATION_XML = '<?xml version="1.0" encoding="UTF-8"?>' "<NotificationConfiguration/>"


class TestValidateNotificationTargetsLambda:
    """Tests for Lambda ARN validation in _validate_notification_targets."""

    def test_valid_lambda_arn_with_matching_compute_provider_returns_none(self) -> None:
        # Arrange
        expected_result = None
        mock_compute = MagicMock()
        compute_providers = {"my-func": mock_compute}

        # Act
        actual_result = _validate_notification_targets(
            _LAMBDA_NOTIFICATION_XML,
            sns_provider=None,
            sqs_provider=None,
            compute_providers=compute_providers,
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected None for valid Lambda ARN but got: {actual_result}"

    def test_lambda_arn_with_no_matching_compute_provider_returns_400(self) -> None:
        # Arrange
        expected_status_code = 400
        compute_providers: dict = {}

        # Act
        actual_result = _validate_notification_targets(
            _LAMBDA_NOTIFICATION_XML,
            sns_provider=None,
            sqs_provider=None,
            compute_providers=compute_providers,
        )

        # Assert
        assert actual_result is not None, "Expected a 400 Response but got None"
        assert (
            actual_result.status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_result.status_code}"

    def test_lambda_arn_with_compute_providers_none_returns_400(self) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        actual_result = _validate_notification_targets(
            _LAMBDA_NOTIFICATION_XML,
            sns_provider=None,
            sqs_provider=None,
            compute_providers=None,
        )

        # Assert
        assert actual_result is not None, "Expected a 400 Response but got None"
        assert (
            actual_result.status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_result.status_code}"

    def test_non_lambda_targets_not_affected_by_compute_providers_validation(self) -> None:
        # Arrange
        expected_result = None
        empty_xml = _EMPTY_NOTIFICATION_XML

        # Act
        actual_result = _validate_notification_targets(
            empty_xml,
            sns_provider=None,
            sqs_provider=None,
            compute_providers=None,
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected None for empty notification config but got: {actual_result}"

    def test_lambda_arn_function_name_extracted_from_full_arn(self) -> None:
        # Arrange
        expected_result = None
        mock_compute = MagicMock()
        compute_providers = {"my-func": mock_compute}

        # Act
        actual_result = _validate_notification_targets(
            _LAMBDA_NOTIFICATION_XML,
            sns_provider=None,
            sqs_provider=None,
            compute_providers=compute_providers,
        )

        # Assert
        assert actual_result == expected_result, (
            f"Expected None when function name extracted from full ARN " f"but got: {actual_result}"
        )
