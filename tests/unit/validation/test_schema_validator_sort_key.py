"""Tests for ldk.validation.schema_validator."""

from __future__ import annotations

from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.validation.engine import ValidationContext
from ldk.validation.schema_validator import SchemaValidator

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


class TestSortKey:
    def test_valid_pk_and_sk(self) -> None:
        config = _make_table_config(sk_name="sk", sk_type="S")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1", "sk": "profile"})
        issues = validator.validate(ctx)
        assert issues == []

    def test_missing_sk(self) -> None:
        config = _make_table_config(sk_name="sk", sk_type="S")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "Missing required key attribute 'sk'" in issues[0].message

    def test_sk_type_mismatch(self) -> None:
        config = _make_table_config(sk_name="sk", sk_type="N")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1", "sk": {"S": "abc"}})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "type mismatch" in issues[0].message
