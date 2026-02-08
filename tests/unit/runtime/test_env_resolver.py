"""Tests for ldk.runtime.env_resolver (P1-05)."""

from __future__ import annotations

from ldk.runtime.env_resolver import resolve_env_vars

# ---------------------------------------------------------------------------
# Plain string passthrough
# ---------------------------------------------------------------------------


class TestPassthrough:
    """Plain string values are passed through unchanged."""

    def test_plain_strings_unchanged(self) -> None:
        env = {"MY_VAR": "hello", "OTHER": "world"}
        result = resolve_env_vars(env, resource_registry={})
        assert result == {"MY_VAR": "hello", "OTHER": "world"}

    def test_empty_env(self) -> None:
        result = resolve_env_vars({}, resource_registry={})
        assert result == {}


# ---------------------------------------------------------------------------
# Ref resolution
# ---------------------------------------------------------------------------


class TestRef:
    """Ref intrinsic function resolution."""

    def test_ref_resolves_from_registry(self) -> None:
        env = {"TABLE_NAME": {"Ref": "MyTable"}}
        registry = {"MyTable": "local-my-table"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["TABLE_NAME"] == "local-my-table"

    def test_ref_unresolvable_uses_logical_id(self) -> None:
        env = {"TABLE_NAME": {"Ref": "UnknownResource"}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["TABLE_NAME"] == "UnknownResource"


# ---------------------------------------------------------------------------
# Fn::GetAtt resolution
# ---------------------------------------------------------------------------


class TestFnGetAtt:
    """Fn::GetAtt intrinsic function resolution."""

    def test_get_att_resolves_from_registry(self) -> None:
        env = {"TABLE_ARN": {"Fn::GetAtt": ["MyTable", "Arn"]}}
        registry = {"MyTable.Arn": "arn:aws:dynamodb:us-east-1:000:table/T"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["TABLE_ARN"] == "arn:aws:dynamodb:us-east-1:000:table/T"

    def test_get_att_unresolvable_uses_composite_key(self) -> None:
        env = {"TABLE_ARN": {"Fn::GetAtt": ["UnknownTable", "Arn"]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["TABLE_ARN"] == "UnknownTable.Arn"


# ---------------------------------------------------------------------------
# Fn::Join resolution
# ---------------------------------------------------------------------------


class TestFnJoin:
    """Fn::Join intrinsic function resolution."""

    def test_join_with_delimiter(self) -> None:
        env = {"URL": {"Fn::Join": ["-", ["hello", "world"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["URL"] == "hello-world"

    def test_join_with_empty_delimiter(self) -> None:
        env = {"URL": {"Fn::Join": ["", ["https://", "example", ".com"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["URL"] == "https://example.com"

    def test_join_resolves_nested_refs(self) -> None:
        env = {
            "ENDPOINT": {
                "Fn::Join": [
                    "/",
                    ["https://api.example.com", {"Ref": "ApiStage"}],
                ]
            }
        }
        registry = {"ApiStage": "prod"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["ENDPOINT"] == "https://api.example.com/prod"


# ---------------------------------------------------------------------------
# Fn::Sub resolution
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


# ---------------------------------------------------------------------------
# Fn::Select resolution
# ---------------------------------------------------------------------------


class TestFnSelect:
    """Fn::Select intrinsic function resolution."""

    def test_select_by_index(self) -> None:
        env = {"AZ": {"Fn::Select": [1, ["us-east-1a", "us-east-1b", "us-east-1c"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["AZ"] == "us-east-1b"

    def test_select_first_element(self) -> None:
        env = {"FIRST": {"Fn::Select": [0, ["alpha", "beta", "gamma"]]}}
        result = resolve_env_vars(env, resource_registry={})
        assert result["FIRST"] == "alpha"

    def test_select_with_nested_ref(self) -> None:
        env = {"CHOICE": {"Fn::Select": [0, [{"Ref": "MyResource"}, "fallback"]]}}
        registry = {"MyResource": "resolved-value"}
        result = resolve_env_vars(env, resource_registry=registry)
        assert result["CHOICE"] == "resolved-value"


# ---------------------------------------------------------------------------
# Mixed / integration
# ---------------------------------------------------------------------------


class TestMixed:
    """Combined scenarios with multiple intrinsic types."""

    def test_mixed_env_with_multiple_types(self) -> None:
        env = {
            "PLAIN": "just-a-string",
            "TABLE": {"Ref": "MyTable"},
            "ARN": {"Fn::GetAtt": ["MyTable", "Arn"]},
            "JOINED": {"Fn::Join": [",", ["a", "b", "c"]]},
            "SUBBED": {"Fn::Sub": "prefix-${MyTable}"},
            "SELECTED": {"Fn::Select": [2, ["x", "y", "z"]]},
        }
        registry = {
            "MyTable": "local-table",
            "MyTable.Arn": "arn:aws:dynamodb:us-east-1:000:table/local-table",
        }
        result = resolve_env_vars(env, resource_registry=registry)

        assert result["PLAIN"] == "just-a-string"
        assert result["TABLE"] == "local-table"
        assert result["ARN"] == "arn:aws:dynamodb:us-east-1:000:table/local-table"
        assert result["JOINED"] == "a,b,c"
        assert result["SUBBED"] == "prefix-local-table"
        assert result["SELECTED"] == "z"
