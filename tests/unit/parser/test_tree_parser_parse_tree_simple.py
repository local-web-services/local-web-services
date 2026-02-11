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


class TestParseTreeSimple:
    """Simple single-stack tree with a couple of resources."""

    def test_single_stack_with_lambda(self, tmp_tree):
        # Arrange
        expected_stack_id = "MyStack"
        expected_stack_path = "MyStack"
        expected_func_id = "MyFunc"
        expected_fqn = "aws-cdk-lib.aws_lambda.Function"
        expected_category = "lambda"
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    expected_stack_id: {
                        "id": expected_stack_id,
                        "path": expected_stack_path,
                        "children": {
                            expected_func_id: {
                                "id": expected_func_id,
                                "path": "MyStack/MyFunc",
                                "constructInfo": {
                                    "fqn": expected_fqn,
                                    "version": "2.100.0",
                                },
                            }
                        },
                        "constructInfo": {
                            "fqn": "aws-cdk-lib.Stack",
                            "version": "2.100.0",
                        },
                    }
                },
            },
        }

        # Act
        nodes = parse_tree(tmp_tree(data))

        # Assert
        assert len(nodes) == 1
        stack = nodes[0]
        assert stack.id == expected_stack_id
        assert stack.path == expected_stack_path
        assert len(stack.children) == 1
        func = stack.children[0]
        assert func.id == expected_func_id
        assert func.fqn == expected_fqn
        assert func.category == expected_category

    def test_node_without_construct_info(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "MyStack": {
                        "id": "MyStack",
                        "path": "MyStack",
                        "children": {
                            "BareNode": {
                                "id": "BareNode",
                                "path": "MyStack/BareNode",
                            }
                        },
                    }
                },
            },
        }
        nodes = parse_tree(tmp_tree(data))
        stack = nodes[0]
        bare = stack.children[0]
        assert bare.fqn is None
        assert bare.category is None
