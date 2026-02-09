"""Tests for ldk.validation.integration."""

from __future__ import annotations

from lws.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.validation.engine import ValidationLevel
from lws.validation.integration import (
    create_validation_engine,
    validate_dynamodb_operation,
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
