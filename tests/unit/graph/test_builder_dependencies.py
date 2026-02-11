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
        # Arrange
        expected_dependencies = ["table"]
        graph = self._make_chain_graph()

        # Act
        actual_dependencies = graph.get_dependencies("fn")

        # Assert
        assert actual_dependencies == expected_dependencies

    def test_get_dependencies_ignores_trigger_edges(self) -> None:
        # Arrange
        graph = self._make_chain_graph()

        # Act
        # API has a TRIGGER edge, not DATA_DEPENDENCY, so no dependencies.
        actual_dependencies = graph.get_dependencies("api")

        # Assert
        assert actual_dependencies == []

    def test_get_dependents_returns_data_sources(self) -> None:
        # Arrange
        expected_dependents = ["fn"]
        graph = self._make_chain_graph()

        # Act
        actual_dependents = graph.get_dependents("table")

        # Assert
        assert actual_dependents == expected_dependents

    def test_get_dependents_empty_for_leaf(self) -> None:
        # Arrange
        graph = self._make_chain_graph()

        # Act
        actual_dependents = graph.get_dependents("api")

        # Assert
        assert actual_dependents == []
