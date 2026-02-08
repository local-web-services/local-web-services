"""Validation engine integration for providers.

Provides a convenience API for wiring validators into provider operation
paths. This module creates a pre-configured ValidationEngine and exposes
a ``validate_operation`` function that providers can call before executing
operations.

Since providers are developed in parallel, this module provides a clean
API that can be plugged in later without modifying existing code.
"""

from __future__ import annotations

from typing import Any

from ldk.graph.builder import AppGraph
from ldk.interfaces import TableConfig
from ldk.validation.engine import (
    ValidationContext,
    ValidationEngine,
    ValidationIssue,
)
from ldk.validation.event_shape_validator import EventShapeValidator
from ldk.validation.permission_validator import PermissionValidator
from ldk.validation.schema_validator import SchemaValidator


def create_validation_engine(
    strictness: str = "warn",
    app_graph: AppGraph | None = None,
    table_configs: dict[str, TableConfig] | None = None,
    validator_overrides: dict[str, str] | None = None,
) -> ValidationEngine:
    """Create a fully wired ValidationEngine with standard validators.

    Parameters
    ----------
    strictness:
        Global strictness mode (``"warn"`` or ``"strict"``).
    app_graph:
        The application graph for permission and env-var validation.
    table_configs:
        DynamoDB table configurations keyed by table name for schema validation.
    validator_overrides:
        Per-validator strictness overrides.

    Returns
    -------
    ValidationEngine
        An engine with permission, schema, and event-shape validators registered.
    """
    engine = ValidationEngine(
        strictness=strictness,
        validator_overrides=validator_overrides,
    )

    engine.register(PermissionValidator())

    if table_configs:
        engine.register(SchemaValidator(table_configs))

    engine.register(EventShapeValidator())

    return engine


def validate_operation(
    engine: ValidationEngine,
    handler_id: str,
    resource_id: str,
    operation: str,
    data: dict[str, Any] | None = None,
    app_graph: AppGraph | None = None,
) -> list[ValidationIssue]:
    """Convenience function to validate an operation through the engine.

    Parameters
    ----------
    engine:
        The validation engine to use.
    handler_id:
        The ID of the handler performing the operation.
    resource_id:
        The ID of the target resource.
    operation:
        The operation being performed (e.g. ``"put_item"``).
    data:
        Operation data (item, event, etc.).
    app_graph:
        The application graph for permission checks.

    Returns
    -------
    list[ValidationIssue]
        All issues found. In strict mode, raises ``ValidationError`` instead.
    """
    context = ValidationContext(
        handler_id=handler_id,
        resource_id=resource_id,
        operation=operation,
        data=data or {},
        app_graph=app_graph,
    )
    return engine.validate(context)


def validate_dynamodb_operation(
    engine: ValidationEngine,
    handler_id: str,
    table_name: str,
    operation: str,
    item: dict[str, Any] | None = None,
    app_graph: AppGraph | None = None,
) -> list[ValidationIssue]:
    """Validate a DynamoDB operation (schema + permission checks).

    Parameters
    ----------
    engine:
        The validation engine to use.
    handler_id:
        The handler performing the operation.
    table_name:
        The DynamoDB table name.
    operation:
        The DynamoDB operation (e.g. ``"put_item"``, ``"get_item"``).
    item:
        The item data for write operations.
    app_graph:
        The application graph for permission checks.

    Returns
    -------
    list[ValidationIssue]
        All issues found.
    """
    return validate_operation(
        engine=engine,
        handler_id=handler_id,
        resource_id=table_name,
        operation=operation,
        data=item or {},
        app_graph=app_graph,
    )


def validate_event_shape(
    engine: ValidationEngine,
    handler_id: str,
    trigger_type: str,
    event: dict[str, Any],
) -> list[ValidationIssue]:
    """Validate an event shape before handler invocation.

    Parameters
    ----------
    engine:
        The validation engine to use.
    handler_id:
        The handler that will receive the event.
    trigger_type:
        The type of trigger (e.g. ``"api_gateway"``, ``"sqs"``).
    event:
        The event to validate.

    Returns
    -------
    list[ValidationIssue]
        All issues found.
    """
    return validate_operation(
        engine=engine,
        handler_id=handler_id,
        resource_id=handler_id,
        operation="invoke",
        data={"trigger_type": trigger_type, "event": event},
    )
