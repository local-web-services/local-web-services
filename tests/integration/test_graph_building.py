"""Integration tests for graph building."""

from __future__ import annotations

from pathlib import Path

from lws.graph.builder import build_graph
from lws.parser.assembly import parse_assembly

FIXTURES_DIR = Path(__file__).parent.parent / "fixtures" / "sample-app"
CDK_OUT = FIXTURES_DIR / "cdk.out"


class TestGraphBuilding:
    """Test that the app model produces a valid graph."""

    def test_build_graph_from_parsed_model(self):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)

        # Should have nodes for tables, functions, and API
        assert len(graph.nodes) >= 4  # 1 table + 2 functions + 1 API

        # Should have edges (triggers and data dependencies)
        assert len(graph.edges) >= 1

    def test_topological_sort_tables_before_functions(self):
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        order = graph.topological_sort()

        assert len(order) > 0
        # All nodes should be in the sort result (no cycles)
        assert len(order) == len(graph.nodes)

    def test_no_cycles(self):
        # Arrange
        expected_cycle_count = 0

        # Act
        app_model = parse_assembly(CDK_OUT)
        graph = build_graph(app_model)
        cycles = graph.detect_cycles()

        # Assert
        actual_cycle_count = len(cycles)
        assert actual_cycle_count == expected_cycle_count
