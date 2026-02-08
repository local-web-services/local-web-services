"""Tests for ldk.validation.integration."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.validation.engine import ValidationLevel
from ldk.validation.integration import (
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
