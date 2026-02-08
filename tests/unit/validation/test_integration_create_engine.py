"""Tests for ldk.validation.integration."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.validation.integration import (
    create_validation_engine,
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
