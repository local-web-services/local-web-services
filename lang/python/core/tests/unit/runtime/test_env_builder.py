"""Tests for ldk.runtime.env_builder -- Lambda environment resolution."""

from __future__ import annotations

import json

from lws.runtime.env_builder import build_lambda_env

# ---------------------------------------------------------------------------
# Standard Lambda env vars
# ---------------------------------------------------------------------------


def test_standard_lambda_env_vars_present() -> None:
    """build_lambda_env must always include the standard Lambda variables."""
    # Arrange
    expected_function_name = "MyFunc"
    expected_version = "$LATEST"
    expected_memory_size = "128"
    expected_region = "us-east-1"

    # Act
    env = build_lambda_env(
        function_name=expected_function_name,
        function_env={},
        local_endpoints={},
        resolved_refs={},
    )

    # Assert
    assert env["AWS_LAMBDA_FUNCTION_NAME"] == expected_function_name
    assert env["AWS_LAMBDA_FUNCTION_VERSION"] == expected_version
    assert env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] == expected_memory_size
    assert env["AWS_REGION"] == expected_region
    assert env["AWS_DEFAULT_REGION"] == expected_region


# ---------------------------------------------------------------------------
# Basic env vars are passed through
# ---------------------------------------------------------------------------


def test_basic_env_vars_are_set() -> None:
    """Function env vars that need no resolution should be copied as-is."""
    # Arrange
    expected_my_var = "hello"
    expected_other = "world"

    # Act
    env = build_lambda_env(
        function_name="Fn",
        function_env={"MY_VAR": expected_my_var, "OTHER": expected_other},
        local_endpoints={},
        resolved_refs={},
    )

    # Assert
    assert env["MY_VAR"] == expected_my_var
    assert env["OTHER"] == expected_other


# ---------------------------------------------------------------------------
# SDK endpoint vars are merged
# ---------------------------------------------------------------------------


def test_sdk_endpoint_vars_are_merged() -> None:
    """Local endpoint URLs should appear as AWS_ENDPOINT_URL_ variables."""
    # Arrange
    expected_endpoint = "http://localhost:4566"
    expected_credential = "ldk-local"

    # Act
    env = build_lambda_env(
        function_name="Fn",
        function_env={},
        local_endpoints={"dynamodb": expected_endpoint},
        resolved_refs={},
    )

    # Assert
    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == expected_endpoint
    # Dummy credentials from build_sdk_env
    assert env["AWS_ACCESS_KEY_ID"] == expected_credential
    assert env["AWS_SECRET_ACCESS_KEY"] == expected_credential


# ---------------------------------------------------------------------------
# Resolved refs replace placeholders
# ---------------------------------------------------------------------------


def test_resolved_refs_replace_direct_placeholders() -> None:
    """Values that match a key in resolved_refs should be replaced."""
    # Arrange
    expected_table_name = "local-my-table"

    # Act
    env = build_lambda_env(
        function_name="Fn",
        function_env={"TABLE_NAME": "MyTableLogicalId"},
        local_endpoints={},
        resolved_refs={"MyTableLogicalId": expected_table_name},
    )

    # Assert
    assert env["TABLE_NAME"] == expected_table_name


def test_resolved_refs_replace_json_ref() -> None:
    """JSON-encoded ``{"Ref": "..."}`` values should be resolved."""
    # Arrange
    ref_value = json.dumps({"Ref": "MyBucket"})
    expected_bucket = "local-bucket-name"

    # Act
    env = build_lambda_env(
        function_name="Fn",
        function_env={"BUCKET": ref_value},
        local_endpoints={},
        resolved_refs={"MyBucket": expected_bucket},
    )

    # Assert
    assert env["BUCKET"] == expected_bucket


def test_unresolved_ref_left_as_is() -> None:
    """If a ref is not in resolved_refs, the original value is kept."""
    # Arrange
    expected_value = json.dumps({"Ref": "UnknownResource"})

    # Act
    env = build_lambda_env(
        function_name="Fn",
        function_env={"UNKNOWN": expected_value},
        local_endpoints={},
        resolved_refs={},
    )

    # Assert
    assert env["UNKNOWN"] == expected_value


# ---------------------------------------------------------------------------
# Full integration
# ---------------------------------------------------------------------------


def test_full_merge_order() -> None:
    """SDK env and Lambda standard vars take precedence over function_env."""
    # Arrange
    expected_function_name = "Handler"
    expected_table_arn = "arn:aws:dynamodb:us-east-1:000:table/T"
    expected_setting = "keep-me"
    expected_region = "us-east-1"
    expected_sqs_endpoint = "http://localhost:4567"

    # Act
    env = build_lambda_env(
        function_name=expected_function_name,
        function_env={
            "TABLE_ARN": "arn:placeholder",
            "MY_SETTING": expected_setting,
            # This will be overridden by the standard Lambda var
            "AWS_REGION": "eu-west-1",
        },
        local_endpoints={"sqs": expected_sqs_endpoint},
        resolved_refs={"arn:placeholder": expected_table_arn},
    )

    # Assert
    # Resolved ref
    assert env["TABLE_ARN"] == expected_table_arn
    # Passthrough
    assert env["MY_SETTING"] == expected_setting
    # Standard Lambda var overrides function_env
    assert env["AWS_REGION"] == expected_region
    # SDK endpoint
    assert env["AWS_ENDPOINT_URL_SQS"] == expected_sqs_endpoint
    # Standard Lambda
    assert env["AWS_LAMBDA_FUNCTION_NAME"] == expected_function_name
