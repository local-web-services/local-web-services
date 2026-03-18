"""Tests for ldk.validation.permission_validator."""

from __future__ import annotations

from lws.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from lws.validation.engine import ValidationContext
from lws.validation.permission_validator import PermissionValidator

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_graph_with_grant(grant_type: str) -> AppGraph:
    """Create a graph with a Lambda -> DynamoDB permission edge."""
    graph = AppGraph()
    graph.add_node(GraphNode(id="handler1", node_type=NodeType.LAMBDA_FUNCTION))
    graph.add_node(GraphNode(id="table1", node_type=NodeType.DYNAMODB_TABLE))
    graph.add_edge(
        GraphEdge(
            source="handler1",
            target="table1",
            edge_type=EdgeType.PERMISSION,
            metadata={"grant_type": grant_type},
        )
    )
    return graph


def _make_context(
    handler_id: str = "handler1",
    resource_id: str = "table1",
    operation: str = "put_item",
    app_graph: AppGraph | None = None,
) -> ValidationContext:
    return ValidationContext(
        handler_id=handler_id,
        resource_id=resource_id,
        operation=operation,
        app_graph=app_graph,
    )


# ---------------------------------------------------------------------------
# grantRead permissions
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# grantWrite permissions
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# grantReadWrite permissions
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# No permission edges
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestNoPermission:
    def test_no_edges_produces_error(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_message_fragment = "no permission grant"
        graph = AppGraph()
        graph.add_node(GraphNode(id="handler1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="table1", node_type=NodeType.DYNAMODB_TABLE))
        ctx = _make_context(operation="get_item", app_graph=graph)

        # Act
        issues = PermissionValidator().validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert expected_message_fragment in issues[0].message

    def test_no_graph_returns_empty(self) -> None:
        # Arrange
        ctx = _make_context(operation="get_item", app_graph=None)

        # Act
        issues = PermissionValidator().validate(ctx)

        # Assert
        assert issues == []

    def test_wrong_handler_id_no_match(self) -> None:
        # Arrange
        expected_issue_count = 1
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(handler_id="other_handler", operation="get_item", app_graph=graph)

        # Act
        issues = PermissionValidator().validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count

    def test_wrong_resource_id_no_match(self) -> None:
        # Arrange
        expected_issue_count = 1
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(resource_id="other_table", operation="get_item", app_graph=graph)

        # Act
        issues = PermissionValidator().validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
