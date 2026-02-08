"""Parser for CDK tree.json files.

Walks the construct tree and produces a flat/nested list of ConstructNode
dataclasses that downstream stages use to correlate logical IDs with
CDK-level metadata (FQN, resource category, etc.).
"""

from __future__ import annotations

import json
import logging
from dataclasses import dataclass, field
from pathlib import Path

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Known CDK FQN -> resource-category mapping
# ---------------------------------------------------------------------------
FQN_CATEGORY_MAP: dict[str, str] = {
    "aws-cdk-lib.aws_lambda.Function": "lambda",
    "aws-cdk-lib.aws_lambda_nodejs.NodejsFunction": "lambda",
    "aws-cdk-lib.aws_lambda_python_alpha.PythonFunction": "lambda",
    "aws-cdk-lib.aws_dynamodb.Table": "dynamodb",
    "aws-cdk-lib.aws_dynamodb.TableV2": "dynamodb",
    "aws-cdk-lib.aws_apigateway.RestApi": "apigateway",
    "aws-cdk-lib.aws_apigateway.LambdaRestApi": "apigateway",
    "aws-cdk-lib.aws_apigatewayv2.HttpApi": "apigatewayv2",
    "aws-cdk-lib.aws_apigatewayv2_alpha.HttpApi": "apigatewayv2",
    "aws-cdk-lib.aws_s3.Bucket": "s3",
    "aws-cdk-lib.aws_sqs.Queue": "sqs",
    "aws-cdk-lib.aws_sns.Topic": "sns",
    "aws-cdk-lib.aws_stepfunctions.StateMachine": "stepfunctions",
    "aws-cdk-lib.aws_events.Rule": "events",
}


@dataclass
class ConstructNode:
    """A node in the CDK construct tree."""

    path: str
    id: str
    fqn: str | None = None
    children: list[ConstructNode] = field(default_factory=list)
    cfn_type: str | None = None

    @property
    def category(self) -> str | None:
        """Return a human-friendly resource category derived from the FQN."""
        if self.fqn is not None:
            return FQN_CATEGORY_MAP.get(self.fqn)
        return None


def _walk_node(node_data: dict) -> ConstructNode:
    """Recursively convert a raw tree-JSON dict into a ConstructNode."""
    path = node_data.get("path", "")
    node_id = node_data.get("id", "")

    construct_info = node_data.get("constructInfo", {})
    fqn = construct_info.get("fqn") if construct_info else None

    # Some leaf nodes carry an AWS CloudFormation type directly
    cfn_type = (
        node_data.get("attributes", {}).get("aws:cdk:cloudformation:type")
        if node_data.get("attributes")
        else None
    )

    children: list[ConstructNode] = []
    for child_data in (node_data.get("children") or {}).values():
        children.append(_walk_node(child_data))

    return ConstructNode(
        path=path,
        id=node_id,
        fqn=fqn,
        children=children,
        cfn_type=cfn_type,
    )


def parse_tree(tree_json_path: Path) -> list[ConstructNode]:
    """Parse a CDK ``tree.json`` and return top-level construct nodes.

    Parameters
    ----------
    tree_json_path:
        Absolute or relative path to the ``tree.json`` file emitted by
        ``cdk synth``.

    Returns
    -------
    list[ConstructNode]
        The immediate children of the tree root (typically one node per
        CDK stack).
    """
    with open(tree_json_path, encoding="utf-8") as fh:
        data = json.load(fh)

    tree_root = data.get("tree", data)

    children: list[ConstructNode] = []
    for child_data in (tree_root.get("children") or {}).values():
        children.append(_walk_node(child_data))

    return children
