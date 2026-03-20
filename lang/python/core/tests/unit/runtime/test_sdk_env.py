"""Tests for ldk.runtime.sdk_env."""

from __future__ import annotations

from lws.runtime.sdk_env import build_sdk_env


def test_single_service_endpoint() -> None:
    """A single service should produce one AWS_ENDPOINT_URL_ variable."""
    # Arrange
    expected_endpoint = "http://localhost:4566"

    # Act
    env = build_sdk_env({"dynamodb": expected_endpoint})

    # Assert
    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == expected_endpoint, f'Expected {expected_endpoint!r} but got {env["AWS_ENDPOINT_URL_DYNAMODB"]!r}'


def test_multiple_services() -> None:
    """Multiple services should each get their own AWS_ENDPOINT_URL_ variable."""
    # Arrange
    expected_dynamodb = "http://localhost:4566"
    expected_sqs = "http://localhost:4567"
    expected_s3 = "http://localhost:4568"
    endpoints = {
        "dynamodb": expected_dynamodb,
        "sqs": expected_sqs,
        "s3": expected_s3,
    }

    # Act
    env = build_sdk_env(endpoints)

    # Assert
    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == expected_dynamodb, f'Expected {expected_dynamodb!r} but got {env["AWS_ENDPOINT_URL_DYNAMODB"]!r}'
    assert env["AWS_ENDPOINT_URL_SQS"] == expected_sqs, f'Expected {expected_sqs!r} but got {env["AWS_ENDPOINT_URL_SQS"]!r}'
    assert env["AWS_ENDPOINT_URL_S3"] == expected_s3, f'Expected {expected_s3!r} but got {env["AWS_ENDPOINT_URL_S3"]!r}'


def test_always_includes_dummy_credentials() -> None:
    """Even with services present, dummy credentials and region must be set."""
    # Arrange
    expected_credential = "ldk-local"
    expected_region = "us-east-1"

    # Act
    env = build_sdk_env({"sqs": "http://localhost:4567"})

    # Assert
    assert env["AWS_ACCESS_KEY_ID"] == expected_credential, f'Expected {expected_credential!r} but got {env["AWS_ACCESS_KEY_ID"]!r}'
    assert env["AWS_SECRET_ACCESS_KEY"] == expected_credential, f'Expected {expected_credential!r} but got {env["AWS_SECRET_ACCESS_KEY"]!r}'
    assert env["AWS_DEFAULT_REGION"] == expected_region, f'Expected {expected_region!r} but got {env["AWS_DEFAULT_REGION"]!r}'


def test_empty_endpoints_still_has_credentials() -> None:
    """An empty endpoints dict should still return credentials and region."""
    # Arrange
    expected_credential = "ldk-local"
    expected_region = "us-east-1"

    # Act
    env = build_sdk_env({})

    # Assert
    assert env["AWS_ACCESS_KEY_ID"] == expected_credential, f'Expected {expected_credential!r} but got {env["AWS_ACCESS_KEY_ID"]!r}'
    assert env["AWS_SECRET_ACCESS_KEY"] == expected_credential, f'Expected {expected_credential!r} but got {env["AWS_SECRET_ACCESS_KEY"]!r}'
    assert env["AWS_DEFAULT_REGION"] == expected_region, f'Expected {expected_region!r} but got {env["AWS_DEFAULT_REGION"]!r}'
    # No endpoint URL vars should be present
    endpoint_keys = [k for k in env if k.startswith("AWS_ENDPOINT_URL_")]
    assert endpoint_keys == [], f"Expected {[]!r} but got {endpoint_keys!r}"


def test_s3_endpoint_sets_force_path_style() -> None:
    """When s3 is in endpoints, AWS_S3_FORCE_PATH_STYLE should be set to true."""
    # Arrange
    expected_value = "true"

    # Act
    env = build_sdk_env({"s3": "http://localhost:4568"})

    # Assert
    assert env["AWS_S3_FORCE_PATH_STYLE"] == expected_value, f'Expected {expected_value!r} but got {env["AWS_S3_FORCE_PATH_STYLE"]!r}'


def test_no_s3_endpoint_omits_force_path_style() -> None:
    """When s3 is not in endpoints, AWS_S3_FORCE_PATH_STYLE should not be set."""
    # Arrange / Act
    env = build_sdk_env({"dynamodb": "http://localhost:4566"})

    # Assert
    assert "AWS_S3_FORCE_PATH_STYLE" not in env, f'Expected {"AWS_S3_FORCE_PATH_STYLE"!r} to not be in {env!r}'


def test_service_name_uppercased() -> None:
    """Service names with mixed case should be uppercased in the env var name."""
    # Arrange
    expected_endpoint = "http://localhost:4566"

    # Act
    env = build_sdk_env({"DynamoDB": expected_endpoint})

    # Assert
    assert "AWS_ENDPOINT_URL_DYNAMODB" in env, f'Expected {"AWS_ENDPOINT_URL_DYNAMODB"!r} to be in {env!r}'
    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == expected_endpoint, f'Expected {expected_endpoint!r} but got {env["AWS_ENDPOINT_URL_DYNAMODB"]!r}'
