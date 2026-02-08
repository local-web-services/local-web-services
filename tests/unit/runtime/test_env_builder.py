"""Tests for ldk.runtime.env_builder -- Lambda environment resolution."""

from __future__ import annotations

import json

from ldk.runtime.env_builder import build_lambda_env

# ---------------------------------------------------------------------------
# Standard Lambda env vars
# ---------------------------------------------------------------------------


def test_standard_lambda_env_vars_present() -> None:
    """build_lambda_env must always include the standard Lambda variables."""
    env = build_lambda_env(
        function_name="MyFunc",
        function_env={},
        local_endpoints={},
        resolved_refs={},
    )

    assert env["AWS_LAMBDA_FUNCTION_NAME"] == "MyFunc"
    assert env["AWS_LAMBDA_FUNCTION_VERSION"] == "$LATEST"
    assert env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] == "128"
    assert env["AWS_REGION"] == "us-east-1"
    assert env["AWS_DEFAULT_REGION"] == "us-east-1"


# ---------------------------------------------------------------------------
# Basic env vars are passed through
# ---------------------------------------------------------------------------


def test_basic_env_vars_are_set() -> None:
    """Function env vars that need no resolution should be copied as-is."""
    env = build_lambda_env(
        function_name="Fn",
        function_env={"MY_VAR": "hello", "OTHER": "world"},
        local_endpoints={},
        resolved_refs={},
    )

    assert env["MY_VAR"] == "hello"
    assert env["OTHER"] == "world"


# ---------------------------------------------------------------------------
# SDK endpoint vars are merged
# ---------------------------------------------------------------------------


def test_sdk_endpoint_vars_are_merged() -> None:
    """Local endpoint URLs should appear as AWS_ENDPOINT_URL_ variables."""
    env = build_lambda_env(
        function_name="Fn",
        function_env={},
        local_endpoints={"dynamodb": "http://localhost:4566"},
        resolved_refs={},
    )

    assert env["AWS_ENDPOINT_URL_DYNAMODB"] == "http://localhost:4566"
    # Dummy credentials from build_sdk_env
    assert env["AWS_ACCESS_KEY_ID"] == "ldk-local"
    assert env["AWS_SECRET_ACCESS_KEY"] == "ldk-local"


# ---------------------------------------------------------------------------
# Resolved refs replace placeholders
# ---------------------------------------------------------------------------


def test_resolved_refs_replace_direct_placeholders() -> None:
    """Values that match a key in resolved_refs should be replaced."""
    env = build_lambda_env(
        function_name="Fn",
        function_env={"TABLE_NAME": "MyTableLogicalId"},
        local_endpoints={},
        resolved_refs={"MyTableLogicalId": "local-my-table"},
    )

    assert env["TABLE_NAME"] == "local-my-table"


def test_resolved_refs_replace_json_ref() -> None:
    """JSON-encoded ``{"Ref": "..."}`` values should be resolved."""
    ref_value = json.dumps({"Ref": "MyBucket"})
    env = build_lambda_env(
        function_name="Fn",
        function_env={"BUCKET": ref_value},
        local_endpoints={},
        resolved_refs={"MyBucket": "local-bucket-name"},
    )

    assert env["BUCKET"] == "local-bucket-name"


def test_unresolved_ref_left_as_is() -> None:
    """If a ref is not in resolved_refs, the original value is kept."""
    ref_value = json.dumps({"Ref": "UnknownResource"})
    env = build_lambda_env(
        function_name="Fn",
        function_env={"UNKNOWN": ref_value},
        local_endpoints={},
        resolved_refs={},
    )

    assert env["UNKNOWN"] == ref_value


# ---------------------------------------------------------------------------
# Full integration
# ---------------------------------------------------------------------------


def test_full_merge_order() -> None:
    """SDK env and Lambda standard vars take precedence over function_env."""
    env = build_lambda_env(
        function_name="Handler",
        function_env={
            "TABLE_ARN": "arn:placeholder",
            "MY_SETTING": "keep-me",
            # This will be overridden by the standard Lambda var
            "AWS_REGION": "eu-west-1",
        },
        local_endpoints={"sqs": "http://localhost:4567"},
        resolved_refs={"arn:placeholder": "arn:aws:dynamodb:us-east-1:000:table/T"},
    )

    # Resolved ref
    assert env["TABLE_ARN"] == "arn:aws:dynamodb:us-east-1:000:table/T"
    # Passthrough
    assert env["MY_SETTING"] == "keep-me"
    # Standard Lambda var overrides function_env
    assert env["AWS_REGION"] == "us-east-1"
    # SDK endpoint
    assert env["AWS_ENDPOINT_URL_SQS"] == "http://localhost:4567"
    # Standard Lambda
    assert env["AWS_LAMBDA_FUNCTION_NAME"] == "Handler"
