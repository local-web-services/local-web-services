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


class TestMissingConstructInfo:
    """Edge cases around missing or empty constructInfo."""

    def test_empty_construct_info_dict(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "S": {
                        "id": "S",
                        "path": "S",
                        "constructInfo": {},
                    }
                },
            },
        }
        nodes = parse_tree(tmp_tree(data))
        assert nodes[0].fqn is None

    def test_construct_info_with_unknown_fqn(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "S": {
                        "id": "S",
                        "path": "S",
                        "constructInfo": {
                            "fqn": "some.custom.Construct",
                        },
                    }
                },
            },
        }
        nodes = parse_tree(tmp_tree(data))
        assert nodes[0].fqn == "some.custom.Construct"
        assert nodes[0].category is None
