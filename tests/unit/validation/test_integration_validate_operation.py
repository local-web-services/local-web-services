"""Tests for ldk.validation.integration."""

from __future__ import annotations

import pytest

from lws.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from lws.interfaces import KeyAttribute, KeySchema, TableConfig
from lws.validation.engine import ValidationError, ValidationLevel
from lws.validation.integration import (
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


class TestValidateOperation:
    def test_valid_operation(self) -> None:
        # Arrange
        graph = _make_graph_with_permission("grantReadWrite")
        engine = create_validation_engine(
            table_configs=_make_table_config(),
            app_graph=graph,
        )

        # Act
        issues = validate_operation(
            engine,
            handler_id="handler1",
            resource_id="users",
            operation="put_item",
            data={"pk": "user-1", "sk": "profile"},
            app_graph=graph,
        )

        # Assert
        assert issues == []

    def test_permission_denied(self) -> None:
        # Arrange
        expected_min_error_issues = 1
        graph = _make_graph_with_permission("grantRead")
        engine = create_validation_engine(app_graph=graph)

        # Act
        issues = validate_operation(
            engine,
            handler_id="handler1",
            resource_id="users",
            operation="put_item",
            app_graph=graph,
        )

        # Assert
        actual_error_issues = [i for i in issues if i.level == ValidationLevel.ERROR]
        assert len(actual_error_issues) >= expected_min_error_issues

    def test_strict_mode_raises(self) -> None:
        # Arrange
        graph = _make_graph_with_permission("grantRead")
        engine = create_validation_engine(strictness="strict", app_graph=graph)

        # Act / Assert
        with pytest.raises(ValidationError):
            validate_operation(
                engine,
                handler_id="handler1",
                resource_id="users",
                operation="put_item",
                app_graph=graph,
            )
