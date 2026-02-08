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


class TestCfnTypeAttribute:
    """Nodes with ``attributes.aws:cdk:cloudformation:type``."""

    def test_cfn_type_extracted(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "S": {
                        "id": "S",
                        "path": "S",
                        "children": {
                            "Res": {
                                "id": "Res",
                                "path": "S/Res",
                                "attributes": {
                                    "aws:cdk:cloudformation:type": "AWS::Lambda::Function",
                                },
                            }
                        },
                    }
                },
            },
        }
        nodes = parse_tree(tmp_tree(data))
        res = nodes[0].children[0]
        assert res.cfn_type == "AWS::Lambda::Function"
