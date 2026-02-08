"""Tests for ldk.validation.integration."""

from __future__ import annotations

import pytest

from ldk.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.validation.engine import ValidationError, ValidationLevel
from ldk.validation.integration import (
    create_validation_engine,
    validate_dynamodb_operation,
    validate_event_shape,
    validate_operation,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_graph_with_permission(grant_type: str = "grantReadWrite") -> AppGraph:
    graph = AppGraph()
    graph.add_node(GraphNode(id="handler1", node_type=NodeType.LAMBDA_FUNCTION))
    graph.add_node(GraphNode(id="users", node_type=NodeType.DYNAMODB_TABLE))
    graph.add_edge(
        GraphEdge(
            source="handler1",
            target="users",
            edge_type=EdgeType.PERMISSION,
            metadata={"grant_type": grant_type},
        )
    )
    return graph


def _make_table_config() -> dict[str, TableConfig]:
    return {
        "users": TableConfig(
            table_name="users",
            key_schema=KeySchema(
                partition_key=KeyAttribute(name="pk", type="S"),
                sort_key=KeyAttribute(name="sk", type="S"),
            ),
        )
    }


# ---------------------------------------------------------------------------
# create_validation_engine
# ---------------------------------------------------------------------------


class TestCreateEngine:
    def test_creates_engine_with_default_strictness(self) -> None:
        engine = create_validation_engine()
        # Should not raise
        issues = validate_operation(
            engine,
            handler_id="h",
            resource_id="r",
            operation="get_item",
        )
        # No graph, no table configs -> some validators produce no issues
        assert isinstance(issues, list)

    def test_creates_engine_with_table_configs(self) -> None:
        engine = create_validation_engine(table_configs=_make_table_config())
        # Engine should have schema validator registered
        assert len(engine._validators) >= 2

    def test_creates_engine_with_strict_mode(self) -> None:
        engine = create_validation_engine(strictness="strict")
        # Should create without error
        assert engine._strictness.value == "strict"


# ---------------------------------------------------------------------------
# validate_operation
# ---------------------------------------------------------------------------


class TestValidateOperation:
    def test_valid_operation(self) -> None:
        graph = _make_graph_with_permission("grantReadWrite")
        engine = create_validation_engine(
            table_configs=_make_table_config(),
            app_graph=graph,
        )
        issues = validate_operation(
            engine,
            handler_id="handler1",
            resource_id="users",
            operation="put_item",
            data={"pk": "user-1", "sk": "profile"},
            app_graph=graph,
        )
        assert issues == []

    def test_permission_denied(self) -> None:
        graph = _make_graph_with_permission("grantRead")
        engine = create_validation_engine(app_graph=graph)
        issues = validate_operation(
            engine,
            handler_id="handler1",
            resource_id="users",
            operation="put_item",
            app_graph=graph,
        )
        error_issues = [i for i in issues if i.level == ValidationLevel.ERROR]
        assert len(error_issues) >= 1

    def test_strict_mode_raises(self) -> None:
        graph = _make_graph_with_permission("grantRead")
        engine = create_validation_engine(strictness="strict", app_graph=graph)
        with pytest.raises(ValidationError):
            validate_operation(
                engine,
                handler_id="handler1",
                resource_id="users",
                operation="put_item",
                app_graph=graph,
            )


# ---------------------------------------------------------------------------
# validate_dynamodb_operation
# ---------------------------------------------------------------------------


class TestValidateDynamoDBOperation:
    def test_valid_put_item(self) -> None:
        graph = _make_graph_with_permission("grantReadWrite")
        engine = create_validation_engine(
            table_configs=_make_table_config(),
            app_graph=graph,
        )
        issues = validate_dynamodb_operation(
            engine,
            handler_id="handler1",
            table_name="users",
            operation="put_item",
            item={"pk": "u1", "sk": "s1"},
            app_graph=graph,
        )
        assert issues == []

    def test_missing_key_attribute(self) -> None:
        graph = _make_graph_with_permission("grantReadWrite")
        engine = create_validation_engine(
            table_configs=_make_table_config(),
            app_graph=graph,
        )
        issues = validate_dynamodb_operation(
            engine,
            handler_id="handler1",
            table_name="users",
            operation="put_item",
            item={"pk": "u1"},
            app_graph=graph,
        )
        error_issues = [i for i in issues if i.level == ValidationLevel.ERROR]
        assert len(error_issues) >= 1
        assert any("sk" in i.message for i in error_issues)

    def test_no_item_provided(self) -> None:
        graph = _make_graph_with_permission("grantReadWrite")
        engine = create_validation_engine(
            table_configs=_make_table_config(),
            app_graph=graph,
        )
        issues = validate_dynamodb_operation(
            engine,
            handler_id="handler1",
            table_name="users",
            operation="put_item",
            app_graph=graph,
        )
        # Missing pk and sk
        error_issues = [i for i in issues if i.level == ValidationLevel.ERROR]
        assert len(error_issues) >= 2


# ---------------------------------------------------------------------------
# validate_event_shape
# ---------------------------------------------------------------------------


class TestValidateEventShape:
    def test_valid_api_gateway_event(self) -> None:
        engine = create_validation_engine()
        event = {
            "httpMethod": "GET",
            "path": "/users",
            "headers": {},
            "queryStringParameters": None,
            "body": None,
            "requestContext": {},
        }
        issues = validate_event_shape(engine, "handler1", "api_gateway", event)
        assert issues == []

    def test_invalid_api_gateway_event(self) -> None:
        engine = create_validation_engine()
        issues = validate_event_shape(engine, "handler1", "api_gateway", {})
        warn_issues = [i for i in issues if i.level == ValidationLevel.WARN]
        assert len(warn_issues) >= 1

    def test_valid_sqs_event(self) -> None:
        engine = create_validation_engine()
        event = {
            "Records": [
                {
                    "messageId": "m1",
                    "body": "{}",
                    "eventSource": "aws:sqs",
                }
            ]
        }
        issues = validate_event_shape(engine, "handler1", "sqs", event)
        assert issues == []


# ---------------------------------------------------------------------------
# Validator overrides in create_validation_engine
# ---------------------------------------------------------------------------


class TestValidatorOverrides:
    def test_override_permission_to_warn(self) -> None:
        graph = _make_graph_with_permission("grantRead")
        engine = create_validation_engine(
            strictness="strict",
            app_graph=graph,
            validator_overrides={"permission": "warn"},
        )
        # Should NOT raise because permission validator is overridden to warn
        issues = validate_operation(
            engine,
            handler_id="handler1",
            resource_id="users",
            operation="put_item",
            app_graph=graph,
        )
        error_issues = [i for i in issues if i.level == ValidationLevel.ERROR]
        assert len(error_issues) >= 1
