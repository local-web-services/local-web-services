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
        env = {"ARN": {"Fn::Sub": "arn:aws:s3:::${BucketName}"}}
        registry = {"BucketName": "my-local-bucket"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["ARN"] == "arn:aws:s3:::my-local-bucket"

    def test_sub_short_form_unresolvable(self) -> None:
        env = {"ARN": {"Fn::Sub": "arn:aws:s3:::${UnknownBucket}"}}
        result = resolve_env_vars(env, resource_registry={})
        # Unresolvable -- uses logical ID as placeholder
        assert result["ARN"] == "arn:aws:s3:::UnknownBucket"

    def test_sub_long_form_with_local_vars(self) -> None:
        env = {
            "URL": {
                "Fn::Sub": [
                    "https://${Domain}/api/${Stage}",
                    {"Domain": "example.com", "Stage": "v1"},
                ]
            }
        }
        result = resolve_env_vars(env, resource_registry={})
        assert result["URL"] == "https://example.com/api/v1"

    def test_sub_long_form_with_ref_in_vars(self) -> None:
        env = {
            "URL": {
                "Fn::Sub": [
                    "https://${Domain}/${Path}",
                    {"Domain": "example.com", "Path": {"Ref": "ApiPath"}},
                ]
            }
        }
        registry = {"ApiPath": "v2"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["URL"] == "https://example.com/v2"

    def test_sub_multiple_vars_in_template(self) -> None:
        env = {"DSN": {"Fn::Sub": "postgres://${User}:${Pass}@${Host}:5432/${DB}"}}
        registry = {
            "User": "admin",
            "Pass": "secret",
            "Host": "localhost",
            "DB": "mydb",
        }
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["DSN"] == "postgres://admin:secret@localhost:5432/mydb"
