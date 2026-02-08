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


class TestAddNodeAndEdge:
    def test_add_node(self) -> None:
        graph = AppGraph()
        node = GraphNode(id="my-table", node_type=NodeType.DYNAMODB_TABLE)
        graph.add_node(node)

        assert "my-table" in graph.nodes
        assert graph.nodes["my-table"] is node

    def test_add_node_overwrites_duplicate(self) -> None:
        graph = AppGraph()
        node1 = GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION, config={"v": 1})
        node2 = GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION, config={"v": 2})
        graph.add_node(node1)
        graph.add_node(node2)

        assert graph.nodes["fn"].config == {"v": 2}

    def test_add_edge(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        edge = GraphEdge(source="a", target="b", edge_type=EdgeType.TRIGGER)
        graph.add_edge(edge)

        assert len(graph.edges) == 1
        assert graph.edges[0] is edge
