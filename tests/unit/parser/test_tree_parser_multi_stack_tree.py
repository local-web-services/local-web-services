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
        nodes = parse_tree(tmp_tree(data))
        assert len(nodes) == 2
        ids = {n.id for n in nodes}
        assert ids == {"StackA", "StackB"}
        # Verify categories
        stack_a = next(n for n in nodes if n.id == "StackA")
        assert stack_a.children[0].category == "dynamodb"
        stack_b = next(n for n in nodes if n.id == "StackB")
        assert stack_b.children[0].category == "sqs"

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
