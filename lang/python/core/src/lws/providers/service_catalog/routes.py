"""AWS Service Catalog HTTP routes.

Implements the Service Catalog wire protocol using JSON request/response
format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

import json
import uuid

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.per_account_state import (
    DEFAULT_ACCOUNT_ID,
    PerAccountStateRegistry,
    extract_account_id_from_token,
)
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers.service_catalog._sc_state import (
    _Product,
    _ProvisioningArtifact,
    _Record,
    _ScState,
)

_logger = get_logger("ldk.service_catalog")


# ------------------------------------------------------------------
# Response helpers
# ------------------------------------------------------------------


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in Service Catalog format."""
    return _json_response({"__type": code, "message": message}, status_code=status_code)


# ------------------------------------------------------------------
# Formatters
# ------------------------------------------------------------------


def _format_product_view(product: _Product) -> dict:
    """Format a product into a ProductViewDetail dict."""
    return {
        "ProductViewSummary": {
            "Id": "prodview-" + product.product_id,
            "ProductId": product.product_id,
            "Name": product.name,
            "Owner": product.owner,
            "ShortDescription": product.description,
            "Type": "CLOUD_FORMATION_TEMPLATE",
            "HasDefaultPath": True,
        },
        "Status": "CREATED",
        "CreatedTime": product.created_time,
    }


def _format_artifact(artifact: _ProvisioningArtifact) -> dict:
    """Format an artifact into a ProvisioningArtifactDetail dict."""
    return {
        "Id": artifact.artifact_id,
        "Name": artifact.name,
        "Description": artifact.description,
        "Type": artifact.artifact_type,
        "CreatedTime": artifact.created_time,
        "Active": True,
    }


def _format_record(record: _Record) -> dict:
    """Format a record into a RecordDetail dict."""
    return {
        "RecordId": record.record_id,
        "ProvisionedProductId": record.provisioned_product_id,
        "ProductId": record.product_id,
        "Status": record.status,
        "CreatedTime": record.created_time,
        "UpdatedTime": record.created_time,
        "RecordType": "PROVISION_PRODUCT",
        "RecordErrors": [],
        "RecordTags": [],
    }


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_search_products_as_admin(
    state: _ScState, body: dict  # pylint: disable=unused-argument
) -> Response:
    """Return all products in the account's catalogue."""
    product_view_details = [_format_product_view(p) for p in state.products.values()]
    return _json_response({"ProductViewDetails": product_view_details})


async def _handle_describe_product(state: _ScState, body: dict) -> Response:
    """Return product summary and artifacts for a known product ID."""
    product_id = body.get("Id", "")
    product = state.products.get(product_id)
    if product is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Product {product_id} not found.",
            status_code=400,
        )
    artifacts = [_format_artifact(a) for a in product.artifacts]
    return _json_response(
        {
            "ProductViewSummary": _format_product_view(product)["ProductViewSummary"],
            "ProvisioningArtifacts": artifacts,
        }
    )


async def _handle_list_provisioning_artifacts(state: _ScState, body: dict) -> Response:
    """Return provisioning artifact summaries for a product."""
    product_id = body.get("ProductId", "")
    product = state.products.get(product_id)
    if product is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Product {product_id} not found.",
            status_code=400,
        )
    artifact_details = [_format_artifact(a) for a in product.artifacts]
    return _json_response({"ProvisioningArtifactDetails": artifact_details})


async def _handle_list_launch_paths(state: _ScState, body: dict) -> Response:
    """Return at least one launch path summary for a known product."""
    product_id = body.get("ProductId", "")
    product = state.products.get(product_id)
    if product is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Product {product_id} not found.",
            status_code=400,
        )
    return _json_response(
        {"LaunchPathSummaries": [{"Id": product.launch_path_id, "Name": "Default", "Tags": []}]}
    )


async def _handle_provision_product(state: _ScState, body: dict) -> Response:
    """Create a provisioned product record with SUCCEEDED status."""
    product_id = body.get("ProductId", "")
    if not product_id or product_id not in state.products:
        return _error_response(
            "ResourceNotFoundException",
            f"Product {product_id} not found.",
            status_code=400,
        )
    record_id = "rec-" + uuid.uuid4().hex[:8]
    pp_id = "pp-" + uuid.uuid4().hex[:8]
    record = _Record(
        record_id=record_id,
        provisioned_product_id=pp_id,
        product_id=product_id,
    )
    state.records[record_id] = record
    return _json_response({"RecordDetail": _format_record(record)})


async def _handle_describe_record(state: _ScState, body: dict) -> Response:
    """Return record detail for a known RecordId."""
    record_id = body.get("Id", "")
    record = state.records.get(record_id)
    if record is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Record {record_id} not found.",
            status_code=400,
        )
    return _json_response({"RecordDetail": _format_record(record)})


# ------------------------------------------------------------------
# Action dispatch table
# ------------------------------------------------------------------

_ACTION_HANDLERS = {
    "SearchProductsAsAdmin": _handle_search_products_as_admin,
    "DescribeProduct": _handle_describe_product,
    "ListProvisioningArtifacts": _handle_list_provisioning_artifacts,
    "ListLaunchPaths": _handle_list_launch_paths,
    "ProvisionProduct": _handle_provision_product,
    "DescribeRecord": _handle_describe_record,
}


# ------------------------------------------------------------------
# Dispatch + app factory
# ------------------------------------------------------------------


async def _sc_dispatch(request: Request, state: _ScState) -> Response:
    """Dispatch a Service Catalog request to the appropriate handler."""
    target = request.headers.get("x-amz-target", "")
    body = await parse_json_body(request)
    action = resolve_api_action(target, body)
    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        _logger.warning("Unknown Service Catalog action: %s", action)
        return _error_response(
            "InvalidAction",
            f"lws: Service Catalog operation '{action}' is not yet implemented",
        )
    return await handler(state, body)


def create_service_catalog_app(
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    state: _ScState | None = None,
    registry: PerAccountStateRegistry[_ScState] | None = None,
) -> tuple[FastAPI, _ScState]:
    """Create a FastAPI application that speaks the Service Catalog wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for lifecycle management (e.g. reset). The returned state is
    always the default-account state.
    """
    if registry is None:
        registry = PerAccountStateRegistry(_ScState)
        if state is not None:
            registry._accounts[DEFAULT_ACCOUNT_ID] = state  # pylint: disable=protected-access

    default_state = registry.get(DEFAULT_ACCOUNT_ID)

    app = FastAPI(title="LDK Service Catalog")
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="servicecatalog"
        )
    add_iam_auth_middleware(app, "servicecatalog", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="service_catalog")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        """Route a single Service Catalog request to the appropriate handler."""
        token = request.headers.get("X-Amz-Security-Token", "")
        account_id = extract_account_id_from_token(token) if token else DEFAULT_ACCOUNT_ID
        _state = registry.get(account_id)
        return await _sc_dispatch(request, _state)

    return app, default_state
