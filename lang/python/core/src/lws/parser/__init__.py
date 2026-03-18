"""LDK CDK output parser package.

Re-exports the primary public API so callers can do::

    from lws.parser import parse_assembly, AppModel, ConstructNode
"""

from lws.parser.assembly import (
    ApiDefinition,
    ApiRoute,
    AppModel,
    DynamoTable,
    LambdaFunction,
    parse_assembly,
)
from lws.parser.asset_parser import parse_assets
from lws.parser.ref_resolver import RefResolver
from lws.parser.template_parser import (
    ApiGatewayRouteProps,
    CfnResource,
    DynamoTableProps,
    LambdaFunctionProps,
    extract_api_routes,
    extract_dynamo_tables,
    extract_lambda_functions,
    parse_template,
)
from lws.parser.tree_parser import ConstructNode, parse_tree

__all__ = [
    # assembly
    "AppModel",
    "ApiDefinition",
    "ApiRoute",
    "DynamoTable",
    "LambdaFunction",
    "parse_assembly",
    # asset_parser
    "parse_assets",
    # ref_resolver
    "RefResolver",
    # template_parser
    "CfnResource",
    "LambdaFunctionProps",
    "DynamoTableProps",
    "ApiGatewayRouteProps",
    "parse_template",
    "extract_lambda_functions",
    "extract_dynamo_tables",
    "extract_api_routes",
    # tree_parser
    "ConstructNode",
    "parse_tree",
]
