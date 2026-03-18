"""Unit tests for ldk CLI main module."""

from __future__ import annotations

from lws.cli.ldk import (
    _find_node_id,
)
from lws.graph.builder import AppGraph, GraphNode, NodeType


class TestFindNodeId:
    """Tests for _find_node_id."""

    def test_direct_match(self):
        # Arrange
        expected_node_id = "MyTable"
        graph = AppGraph()
        graph.add_node(GraphNode(id=expected_node_id, node_type=NodeType.DYNAMODB_TABLE, config={}))

        # Act
        actual = _find_node_id(graph, NodeType.DYNAMODB_TABLE, expected_node_id)

        # Assert
        assert actual == expected_node_id

    def test_config_match(self):
        # Arrange
        expected_node_id = "TableLogicalId"
        graph = AppGraph()
        graph.add_node(
            GraphNode(
                id=expected_node_id,
                node_type=NodeType.DYNAMODB_TABLE,
                config={"table_name": "Items"},
            )
        )

        # Act
        actual = _find_node_id(graph, NodeType.DYNAMODB_TABLE, "Items")

        # Assert
        assert actual == expected_node_id

    def test_fallback_returns_name(self):
        # Arrange
        expected_fallback = "Unknown"
        graph = AppGraph()

        # Act
        actual = _find_node_id(graph, NodeType.DYNAMODB_TABLE, expected_fallback)

        # Assert
        assert actual == expected_fallback
