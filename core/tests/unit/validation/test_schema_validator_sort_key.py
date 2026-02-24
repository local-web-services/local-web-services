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


class TestSortKey:
    def test_valid_pk_and_sk(self) -> None:
        # Arrange
        config = _make_table_config(sk_name="sk", sk_type="S")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1", "sk": "profile"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert issues == []

    def test_missing_sk(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_message = "Missing required key attribute 'sk'"
        config = _make_table_config(sk_name="sk", sk_type="S")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert expected_message in issues[0].message

    def test_sk_type_mismatch(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_message_fragment = "type mismatch"
        config = _make_table_config(sk_name="sk", sk_type="N")
        validator = SchemaValidator({"users": config})
        ctx = _make_context(data={"pk": "user-1", "sk": {"S": "abc"}})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert expected_message_fragment in issues[0].message
