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


class TestNestedConstructs:
    """Deeply nested constructs."""

    def test_nested_three_levels(self, tmp_tree):
        data = {
            "version": "tree-0.1",
            "tree": {
                "id": "App",
                "path": "",
                "children": {
                    "Stack": {
                        "id": "Stack",
                        "path": "Stack",
                        "children": {
                            "Api": {
                                "id": "Api",
                                "path": "Stack/Api",
                                "constructInfo": {
                                    "fqn": "aws-cdk-lib.aws_apigateway.RestApi",
                                },
                                "children": {
                                    "Resource": {
                                        "id": "Resource",
                                        "path": "Stack/Api/Resource",
                                        "children": {
                                            "Method": {
                                                "id": "Method",
                                                "path": "Stack/Api/Resource/Method",
                                            }
                                        },
                                    }
                                },
                            }
                        },
                    }
                },
            },
        }
        nodes = parse_tree(tmp_tree(data))
        stack = nodes[0]
        api = stack.children[0]
        assert api.category == "apigateway"
        assert len(api.children) == 1
        resource = api.children[0]
        assert resource.id == "Resource"
        assert len(resource.children) == 1
        method = resource.children[0]
        assert method.id == "Method"
