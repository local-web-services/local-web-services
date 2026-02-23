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
from lws.graph.builder import (
    AppGraph,
    EdgeType,
    GraphEdge,
    GraphNode,
    NodeType,
)


class TestTopologicalSort:
    def test_linear_chain(self) -> None:
        """API -> Lambda -> Table should sort as: Table, Lambda, API."""
        # Arrange
        expected_count = 3
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

        # Act
        actual_order = graph.topological_sort()

        # Assert
        assert len(actual_order) == expected_count
        # table must come before fn, fn must come before api
        assert actual_order.index("table") < actual_order.index("fn")
        assert actual_order.index("fn") < actual_order.index("api")

    def test_multiple_independent_routes(self) -> None:
        """Two independent API -> Lambda chains should both appear in full."""
        # Arrange
        expected_count = 4
        graph = AppGraph()
        graph.add_node(GraphNode(id="api1", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="api2", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn2", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(GraphEdge(source="api1", target="fn1", edge_type=EdgeType.TRIGGER))
        graph.add_edge(GraphEdge(source="api2", target="fn2", edge_type=EdgeType.TRIGGER))

        # Act
        actual_order = graph.topological_sort()

        # Assert
        assert len(actual_order) == expected_count
        assert actual_order.index("fn1") < actual_order.index("api1")
        assert actual_order.index("fn2") < actual_order.index("api2")

    def test_empty_graph(self) -> None:
        # Arrange
        graph = AppGraph()

        # Act
        actual_order = graph.topological_sort()

        # Assert
        assert actual_order == []

    def test_single_node(self) -> None:
        # Arrange
        node_id = "solo"
        expected_order = [node_id]
        graph = AppGraph()
        graph.add_node(GraphNode(id=node_id, node_type=NodeType.S3_BUCKET))

        # Act
        actual_order = graph.topological_sort()

        # Assert
        assert actual_order == expected_order

    def test_shared_dependency(self) -> None:
        """Two functions sharing a table dependency."""
        # Arrange
        expected_count = 3
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

        # Act
        actual_order = graph.topological_sort()

        # Assert
        assert len(actual_order) == expected_count
        assert actual_order.index("table") < actual_order.index("fn1")
        assert actual_order.index("table") < actual_order.index("fn2")
