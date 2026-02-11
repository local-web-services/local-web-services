"""Tests for ldk.validation.integration."""

from __future__ import annotations

from lws.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.validation.engine import ValidationLevel
from lws.validation.integration import (
    create_validation_engine,
    validate_event_shape,
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


# ---------------------------------------------------------------------------
# validate_operation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# validate_dynamodb_operation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# validate_event_shape
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Validator overrides in create_validation_engine
# ---------------------------------------------------------------------------


class TestValidateEventShape:
    def test_valid_api_gateway_event(self) -> None:
        # Arrange
        engine = create_validation_engine()
        event = {
            "httpMethod": "GET",
            "path": "/users",
            "headers": {},
            "queryStringParameters": None,
            "body": None,
            "requestContext": {},
        }

        # Act
        issues = validate_event_shape(engine, "handler1", "api_gateway", event)

        # Assert
        assert issues == []

    def test_invalid_api_gateway_event(self) -> None:
        # Arrange
        expected_min_warn_issues = 1
        engine = create_validation_engine()

        # Act
        issues = validate_event_shape(engine, "handler1", "api_gateway", {})

        # Assert
        actual_warn_issues = [i for i in issues if i.level == ValidationLevel.WARN]
        assert len(actual_warn_issues) >= expected_min_warn_issues

    def test_valid_sqs_event(self) -> None:
        # Arrange
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

        # Act
        issues = validate_event_shape(engine, "handler1", "sqs", event)

        # Assert
        assert issues == []
