"""Tests for ldk.validation.permission_validator."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, EdgeType, GraphEdge, GraphNode, NodeType
from ldk.validation.engine import ValidationContext, ValidationLevel
from ldk.validation.permission_validator import PermissionValidator

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


class TestGrantRead:
    def test_read_allows_get(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(operation="get_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_read_allows_query(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(operation="query", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_read_allows_scan(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(operation="scan", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_read_denies_put(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(operation="put_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR
        assert "grantRead" in issues[0].message

    def test_read_denies_delete(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(operation="delete_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR


# ---------------------------------------------------------------------------
# grantWrite permissions
# ---------------------------------------------------------------------------


class TestGrantWrite:
    def test_write_allows_put(self) -> None:
        graph = _make_graph_with_grant("grantWrite")
        ctx = _make_context(operation="put_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_write_allows_delete(self) -> None:
        graph = _make_graph_with_grant("grantWrite")
        ctx = _make_context(operation="delete_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_write_denies_get(self) -> None:
        graph = _make_graph_with_grant("grantWrite")
        ctx = _make_context(operation="get_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR

    def test_write_denies_query(self) -> None:
        graph = _make_graph_with_grant("grantWrite")
        ctx = _make_context(operation="query", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1


# ---------------------------------------------------------------------------
# grantReadWrite permissions
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


# ---------------------------------------------------------------------------
# No permission edges
# ---------------------------------------------------------------------------


class TestNoPermission:
    def test_no_edges_produces_error(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="handler1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="table1", node_type=NodeType.DYNAMODB_TABLE))
        ctx = _make_context(operation="get_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1
        assert "no permission grant" in issues[0].message

    def test_no_graph_returns_empty(self) -> None:
        ctx = _make_context(operation="get_item", app_graph=None)
        issues = PermissionValidator().validate(ctx)
        assert issues == []

    def test_wrong_handler_id_no_match(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(handler_id="other_handler", operation="get_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1

    def test_wrong_resource_id_no_match(self) -> None:
        graph = _make_graph_with_grant("grantRead")
        ctx = _make_context(resource_id="other_table", operation="get_item", app_graph=graph)
        issues = PermissionValidator().validate(ctx)
        assert len(issues) == 1


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestValidatorName:
    def test_name_is_permission(self) -> None:
        assert PermissionValidator().name == "permission"
