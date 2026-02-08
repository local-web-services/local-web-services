"""Tests for ldk.graph.builder."""

from __future__ import annotations

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# add_node / add_edge
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# get_dependencies / get_dependents
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# topological_sort
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# detect_cycles
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# build_graph
# ---------------------------------------------------------------------------
from ldk.graph.builder import (
    AppGraph,
    EdgeType,
    GraphEdge,
    GraphNode,
    NodeType,
)


class TestTopologicalSort:
    def test_linear_chain(self) -> None:
        """API -> Lambda -> Table should sort as: Table, Lambda, API."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="api", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="table", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_edge(GraphEdge(source="api", target="fn", edge_type=EdgeType.TRIGGER))
        graph.add_edge(
            GraphEdge(
                source="fn",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        order = graph.topological_sort()
        assert len(order) == 3
        # table must come before fn, fn must come before api
        assert order.index("table") < order.index("fn")
        assert order.index("fn") < order.index("api")

    def test_multiple_independent_routes(self) -> None:
        """Two independent API -> Lambda chains should both appear in full."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="api1", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="api2", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn2", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(GraphEdge(source="api1", target="fn1", edge_type=EdgeType.TRIGGER))
        graph.add_edge(GraphEdge(source="api2", target="fn2", edge_type=EdgeType.TRIGGER))

        order = graph.topological_sort()
        assert len(order) == 4
        assert order.index("fn1") < order.index("api1")
        assert order.index("fn2") < order.index("api2")

    def test_empty_graph(self) -> None:
        graph = AppGraph()
        assert graph.topological_sort() == []

    def test_single_node(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="solo", node_type=NodeType.S3_BUCKET))
        assert graph.topological_sort() == ["solo"]

    def test_shared_dependency(self) -> None:
        """Two functions sharing a table dependency."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="table", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_node(GraphNode(id="fn1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="fn2", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(
            GraphEdge(
                source="fn1",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="fn2",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        order = graph.topological_sort()
        assert len(order) == 3
        assert order.index("table") < order.index("fn1")
        assert order.index("table") < order.index("fn2")
