"""Tests for ldk.runtime.env_resolver (P1-05)."""

from __future__ import annotations

from lws.runtime.env_resolver import resolve_env_vars

# ---------------------------------------------------------------------------
# Plain string passthrough
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Ref resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::GetAtt resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Join resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Sub resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Fn::Select resolution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Mixed / integration
# ---------------------------------------------------------------------------


class TestFnSub:
    """Fn::Sub intrinsic function resolution."""

    def test_sub_short_form_with_registry(self) -> None:
        # Arrange
        expected_arn = "arn:aws:s3:::my-local-bucket"
        env = {"ARN": {"Fn::Sub": "arn:aws:s3:::${BucketName}"}}
        registry = {"BucketName": "my-local-bucket"}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_arn = result["ARN"]
        assert actual_arn == expected_arn

    def test_sub_short_form_unresolvable(self) -> None:
        # Arrange
        expected_arn = "arn:aws:s3:::UnknownBucket"
        env = {"ARN": {"Fn::Sub": "arn:aws:s3:::${UnknownBucket}"}}

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert -- unresolvable uses logical ID as placeholder
        actual_arn = result["ARN"]
        assert actual_arn == expected_arn

    def test_sub_long_form_with_local_vars(self) -> None:
        # Arrange
        expected_url = "https://example.com/api/v1"
        env = {
            "URL": {
                "Fn::Sub": [
                    "https://${Domain}/api/${Stage}",
                    {"Domain": "example.com", "Stage": "v1"},
                ]
            }
        }

        # Act
        result = resolve_env_vars(env, resource_registry={})

        # Assert
        actual_url = result["URL"]
        assert actual_url == expected_url

    def test_sub_long_form_with_ref_in_vars(self) -> None:
        # Arrange
        expected_url = "https://example.com/v2"
        env = {
            "URL": {
                "Fn::Sub": [
                    "https://${Domain}/${Path}",
                    {"Domain": "example.com", "Path": {"Ref": "ApiPath"}},
                ]
            }
        }
        registry = {"ApiPath": "v2"}

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_url = result["URL"]
        assert actual_url == expected_url

    def test_sub_multiple_vars_in_template(self) -> None:
        # Arrange
        expected_dsn = "postgres://admin:secret@localhost:5432/mydb"
        env = {"DSN": {"Fn::Sub": "postgres://${User}:${Pass}@${Host}:5432/${DB}"}}
        registry = {
            "User": "admin",
            "Pass": "secret",
            "Host": "localhost",
            "DB": "mydb",
        }

        # Act
        result = resolve_env_vars(env, resource_registry=registry)

        # Assert
        actual_dsn = result["DSN"]
        assert actual_dsn == expected_dsn
