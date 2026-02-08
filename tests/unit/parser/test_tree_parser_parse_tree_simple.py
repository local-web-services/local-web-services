"""Tests for ldk.parser.tree_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.tree_parser import parse_tree


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
                            "MyFunc": {
                                "id": "MyFunc",
                                "path": "MyStack/MyFunc",
                                "constructInfo": {
                                    "fqn": "aws-cdk-lib.aws_lambda.Function",
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
        nodes = parse_tree(tmp_tree(data))
        assert len(nodes) == 1
        stack = nodes[0]
        assert stack.id == "MyStack"
        assert stack.path == "MyStack"
        assert len(stack.children) == 1
        func = stack.children[0]
        assert func.id == "MyFunc"
        assert func.fqn == "aws-cdk-lib.aws_lambda.Function"
        assert func.category == "lambda"

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
