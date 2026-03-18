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


class TestGrantReadWrite:
    def test_readwrite_allows_get(self) -> None:
        graph = _make_graph_with_grant("grantReadWrite")
        ctx = _make_context(operation="get_item", app_graph=graph)
        assert PermissionValidator().validate(ctx) == []

    def test_readwrite_allows_put(self) -> None:
        graph = _make_graph_with_grant("grantReadWrite")
        ctx = _make_context(operation="put_item", app_graph=graph)
        assert PermissionValidator().validate(ctx) == []

    def test_readwrite_allows_delete(self) -> None:
        graph = _make_graph_with_grant("grantReadWrite")
        ctx = _make_context(operation="delete_item", app_graph=graph)
        assert PermissionValidator().validate(ctx) == []

    def test_readwrite_allows_query(self) -> None:
        graph = _make_graph_with_grant("grantReadWrite")
        ctx = _make_context(operation="query", app_graph=graph)
        assert PermissionValidator().validate(ctx) == []

    def test_readwrite_allows_scan(self) -> None:
        graph = _make_graph_with_grant("grantReadWrite")
        ctx = _make_context(operation="scan", app_graph=graph)
        assert PermissionValidator().validate(ctx) == []
