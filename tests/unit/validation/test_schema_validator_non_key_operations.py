"""Tests for ldk.validation.schema_validator."""

from __future__ import annotations

from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.validation.engine import ValidationContext
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


class TestNonKeyOperations:
    def test_scan_skipped(self) -> None:
        ctx = _make_context(operation="scan", data={})
        issues = _make_validator().validate(ctx)
        assert issues == []

    def test_query_skipped(self) -> None:
        ctx = _make_context(operation="query", data={})
        issues = _make_validator().validate(ctx)
        assert issues == []
