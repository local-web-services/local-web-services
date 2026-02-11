"""Tests for ldk.parser.tree_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.tree_parser import parse_tree


@pytest.fixture()
def tmp_tree(tmp_path: Path):
    """Helper that writes a tree dict to a temp file and returns the path."""

    def _write(tree_data: dict) -> Path:
        p = tmp_path / "tree.json"
        p.write_text(json.dumps(tree_data), encoding="utf-8")
        return p

    return _write


class TestMultiStackTree:
    """Tree files containing more than one top-level stack."""

    def test_two_stacks(self, tmp_tree):
        # Arrange
        expected_count = 2
        expected_ids = {"StackA", "StackB"}
        expected_stack_a_category = "dynamodb"
        expected_stack_b_category = "sqs"
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "StackA": {
                        "id": "StackA",
                        "path": "StackA",
                        "children": {
                            "Table": {
                                "id": "Table",
                                "path": "StackA/Table",
                                "constructInfo": {
                                    "fqn": "aws-cdk-lib.aws_dynamodb.Table",
                                },
                            }
                        },
                    },
                    "StackB": {
                        "id": "StackB",
                        "path": "StackB",
                        "children": {
                            "Queue": {
                                "id": "Queue",
                                "path": "StackB/Queue",
                                "constructInfo": {
                                    "fqn": "aws-cdk-lib.aws_sqs.Queue",
                                },
                            }
                        },
                    },
                },
            },
        }

        # Act
        nodes = parse_tree(tmp_tree(data))

        # Assert
        assert len(nodes) == expected_count
        actual_ids = {n.id for n in nodes}
        assert actual_ids == expected_ids
        stack_a = next(n for n in nodes if n.id == "StackA")
        actual_stack_a_category = stack_a.children[0].category
        assert actual_stack_a_category == expected_stack_a_category
        stack_b = next(n for n in nodes if n.id == "StackB")
        actual_stack_b_category = stack_b.children[0].category
        assert actual_stack_b_category == expected_stack_b_category

    def test_empty_tree(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
            },
        }
        nodes = parse_tree(tmp_tree(data))
        assert nodes == []
