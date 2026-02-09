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

        assert graph.detect_cycles() == []

    def test_simple_cycle_detected(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(
            GraphEdge(
                source="a",
                target="b",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="b",
                target="a",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        cycles = graph.detect_cycles()
        assert len(cycles) >= 1
        # The cycle must include both a and b
        flat = [nid for cycle in cycles for nid in cycle]
        assert "a" in flat
        assert "b" in flat

    def test_three_node_cycle(self) -> None:
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

        cycles = graph.detect_cycles()
        assert len(cycles) >= 1

    def test_empty_graph_no_cycles(self) -> None:
        graph = AppGraph()
        assert graph.detect_cycles() == []
