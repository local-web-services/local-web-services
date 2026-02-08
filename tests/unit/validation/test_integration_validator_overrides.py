"""Tests for ldk.validation.integration."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from ldk.interfaces import KeyAttribute, KeySchema, TableConfig
from ldk.validation.engine import ValidationLevel
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
