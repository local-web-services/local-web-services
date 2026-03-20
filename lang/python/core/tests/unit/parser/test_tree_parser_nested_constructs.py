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
        # Arrange
        expected_api_category = "apigateway"
        expected_resource_id = "Resource"
        expected_method_id = "Method"
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
                                    expected_resource_id: {
                                        "id": expected_resource_id,
                                        "path": "Stack/Api/Resource",
                                        "children": {
                                            expected_method_id: {
                                                "id": expected_method_id,
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

        # Act
        nodes = parse_tree(tmp_tree(data))

        # Assert
        stack = nodes[0]
        api = stack.children[0]
        assert (
            api.category == expected_api_category
        ), f"Expected {expected_api_category!r} but got {api.category!r}"
        assert len(api.children) == 1, f"Expected {1!r} but got {len(api.children)!r}"
        resource = api.children[0]
        assert (
            resource.id == expected_resource_id
        ), f"Expected {expected_resource_id!r} but got {resource.id!r}"
        assert len(resource.children) == 1, f"Expected {1!r} but got {len(resource.children)!r}"
        method = resource.children[0]
        assert (
            method.id == expected_method_id
        ), f"Expected {expected_method_id!r} but got {method.id!r}"
