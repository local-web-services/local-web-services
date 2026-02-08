"""Tests for ldk.runtime.sdk_env."""

from __future__ import annotations

from ldk.runtime.sdk_env import build_sdk_env


def test_single_service_endpoint() -> None:
    """A single service should produce one AWS_ENDPOINT_URL_ variable."""
    env = build_sdk_env({"dynamodb": "http://localhost:4566"})

    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == "http://localhost:4566"


def test_multiple_services() -> None:
    """Multiple services should each get their own AWS_ENDPOINT_URL_ variable."""
    endpoints = {
        "dynamodb": "http://localhost:4566",
        "sqs": "http://localhost:4567",
        "s3": "http://localhost:4568",
    }
    env = build_sdk_env(endpoints)

    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == "http://localhost:4566"
    assert env["AWS_ENDPOINT_URL_SQS"] == "http://localhost:4567"
    assert env["AWS_ENDPOINT_URL_S3"] == "http://localhost:4568"


def test_always_includes_dummy_credentials() -> None:
    """Even with services present, dummy credentials and region must be set."""
    env = build_sdk_env({"sqs": "http://localhost:4567"})

    assert env["AWS_ACCESS_KEY_ID"] == "ldk-local"
    assert env["AWS_SECRET_ACCESS_KEY"] == "ldk-local"
    assert env["AWS_DEFAULT_REGION"] == "us-east-1"


def test_empty_endpoints_still_has_credentials() -> None:
    """An empty endpoints dict should still return credentials and region."""
    env = build_sdk_env({})

    assert env["AWS_ACCESS_KEY_ID"] == "ldk-local"
    assert env["AWS_SECRET_ACCESS_KEY"] == "ldk-local"
    assert env["AWS_DEFAULT_REGION"] == "us-east-1"
    # No endpoint URL vars should be present
    endpoint_keys = [k for k in env if k.startswith("AWS_ENDPOINT_URL_")]
    assert endpoint_keys == []


def test_service_name_uppercased() -> None:
    """Service names with mixed case should be uppercased in the env var name."""
    env = build_sdk_env({"DynamoDB": "http://localhost:4566"})

    assert "AWS_ENDPOINT_URL_DYNAMODB" in env
    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == "http://localhost:4566"
