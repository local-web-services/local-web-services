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


class TestAddNodeAndEdge:
    def test_add_node(self) -> None:
        # Arrange
        node_id = "my-table"
        graph = AppGraph()
        node = GraphNode(id=node_id, node_type=NodeType.DYNAMODB_TABLE)

        # Act
        graph.add_node(node)

        # Assert
        assert node_id in graph.nodes
        assert graph.nodes[node_id] is node

    def test_add_node_overwrites_duplicate(self) -> None:
        # Arrange
        node_id = "fn"
        expected_config = {"v": 2}
        graph = AppGraph()
        node1 = GraphNode(id=node_id, node_type=NodeType.LAMBDA_FUNCTION, config={"v": 1})
        node2 = GraphNode(id=node_id, node_type=NodeType.LAMBDA_FUNCTION, config=expected_config)

        # Act
        graph.add_node(node1)
        graph.add_node(node2)

        # Assert
        actual_config = graph.nodes[node_id].config
        assert actual_config == expected_config

    def test_add_edge(self) -> None:
        # Arrange
        expected_edge_count = 1
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        edge = GraphEdge(source="a", target="b", edge_type=EdgeType.TRIGGER)

        # Act
        graph.add_edge(edge)

        # Assert
        assert len(graph.edges) == expected_edge_count
        assert graph.edges[0] is edge
