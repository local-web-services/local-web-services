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
