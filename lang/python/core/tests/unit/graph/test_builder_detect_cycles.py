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


class TestDetectCycles:
    def test_dag_has_no_cycles(self) -> None:
        # Arrange
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="c", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_edge(GraphEdge(source="a", target="b", edge_type=EdgeType.TRIGGER))
        graph.add_edge(
            GraphEdge(
                source="b",
                target="c",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        # Act
        actual_cycles = graph.detect_cycles()

        # Assert
        assert actual_cycles == []

    def test_simple_cycle_detected(self) -> None:
        # Arrange
        node_a = "a"
        node_b = "b"
        graph = AppGraph()
        graph.add_node(GraphNode(id=node_a, node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id=node_b, node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(
            GraphEdge(
                source=node_a,
                target=node_b,
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        graph.add_edge(
            GraphEdge(
                source=node_b,
                target=node_a,
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        # Act
        actual_cycles = graph.detect_cycles()

        # Assert
        assert len(actual_cycles) >= 1
        # The cycle must include both a and b
        flat = [nid for cycle in actual_cycles for nid in cycle]
        assert node_a in flat
        assert node_b in flat

    def test_three_node_cycle(self) -> None:
        # Arrange
        graph = AppGraph()
        graph.add_node(GraphNode(id="x", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="y", node_type=NodeType.SQS_QUEUE))
        graph.add_node(GraphNode(id="z", node_type=NodeType.SNS_TOPIC))
        graph.add_edge(
            GraphEdge(
                source="x",
                target="y",
                edge_type=EdgeType.EVENT_SOURCE,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="y",
                target="z",
                edge_type=EdgeType.TRIGGER,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="z",
                target="x",
                edge_type=EdgeType.TRIGGER,
            )
        )

        # Act
        actual_cycles = graph.detect_cycles()

        # Assert
        assert len(actual_cycles) >= 1

    def test_empty_graph_no_cycles(self) -> None:
        # Arrange
        graph = AppGraph()

        # Act
        actual_cycles = graph.detect_cycles()

        # Assert
        assert actual_cycles == []
