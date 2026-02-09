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


class TestDependencies:
    def _make_chain_graph(self) -> AppGraph:
        """API --TRIGGER--> Lambda --DATA_DEPENDENCY--> Table."""
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
        return graph

    def test_get_dependencies_returns_data_targets(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependencies("fn") == ["table"]

    def test_get_dependencies_ignores_trigger_edges(self) -> None:
        graph = self._make_chain_graph()
        # API has a TRIGGER edge, not DATA_DEPENDENCY, so no dependencies.
        assert graph.get_dependencies("api") == []

    def test_get_dependents_returns_data_sources(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependents("table") == ["fn"]

    def test_get_dependents_empty_for_leaf(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependents("api") == []
