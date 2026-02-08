"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from ldk.cli.main import (
    _find_node_id,
)
from ldk.graph.builder import AppGraph, GraphNode, NodeType


class TestFindNodeId:
    """Tests for _find_node_id."""

    def test_direct_match(self):
        graph = AppGraph()
        graph.add_node(GraphNode(id="MyTable", node_type=NodeType.DYNAMODB_TABLE, config={}))
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "MyTable")
        assert result == "MyTable"

    def test_config_match(self):
        graph = AppGraph()
        graph.add_node(
            GraphNode(
                id="TableLogicalId",
                node_type=NodeType.DYNAMODB_TABLE,
                config={"table_name": "Items"},
            )
        )
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "Items")
        assert result == "TableLogicalId"

    def test_fallback_returns_name(self):
        graph = AppGraph()
        result = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "Unknown")
        assert result == "Unknown"
