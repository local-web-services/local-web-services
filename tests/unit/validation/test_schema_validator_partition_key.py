"""Tests for ldk.validation.schema_validator."""

from __future__ import annotations

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.validation.engine import ValidationContext, ValidationLevel
from lws.validation.schema_validator import SchemaValidator

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_table_config(
    table_name: str = "users",
    pk_name: str = "pk",
    pk_type: str = "S",
    sk_name: str | None = None,
    sk_type: str = "S",
) -> TableConfig:
    sort_key = KeyAttribute(name=sk_name, type=sk_type) if sk_name else None
    return TableConfig(
        table_name=table_name,
        key_schema=KeySchema(
            partition_key=KeyAttribute(name=pk_name, type=pk_type),
            sort_key=sort_key,
        ),
    )


def _make_validator(configs: dict[str, TableConfig] | None = None) -> SchemaValidator:
    if configs is None:
        configs = {"users": _make_table_config()}
    return SchemaValidator(configs)


def _make_context(
    resource_id: str = "users",
    operation: str = "put_item",
    data: dict | None = None,
) -> ValidationContext:
    return ValidationContext(
        handler_id="handler1",
        resource_id=resource_id,
        operation=operation,
        data=data or {},
    )


# ---------------------------------------------------------------------------
# Partition key validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Sort key validation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Numeric key types
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Non-key operations are skipped
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Unknown table
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Multiple issues
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestPartitionKey:
    def test_valid_pk_plain_string(self) -> None:
        ctx = _make_context(data={"pk": "user-123"})
        issues = _make_validator().validate(ctx)
        assert issues == []

    def test_valid_pk_dynamo_json(self) -> None:
        ctx = _make_context(data={"pk": {"S": "user-123"}})
        issues = _make_validator().validate(ctx)
        assert issues == []

    def test_missing_pk(self) -> None:
        ctx = _make_context(data={})
        issues = _make_validator().validate(ctx)
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR
        assert "Missing required key attribute 'pk'" in issues[0].message

    def test_pk_type_mismatch_dynamo_json(self) -> None:
        ctx = _make_context(data={"pk": {"N": "123"}})
        issues = _make_validator().validate(ctx)
        assert len(issues) == 1
        assert "type mismatch" in issues[0].message
        assert "'S'" in issues[0].message
        assert "'N'" in issues[0].message

    def test_pk_type_mismatch_plain_value(self) -> None:
        configs = {"users": _make_table_config(pk_type="S")}
        validator = _make_validator(configs)
        ctx = _make_context(data={"pk": 123})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "type mismatch" in issues[0].message
