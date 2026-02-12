"""Shared search-service factory for Elasticsearch and OpenSearch providers.

Both services share nearly identical domain CRUD, tag management, and response
formatting logic.  This module parameterises the differences via a config
dataclass so each provider is a thin wrapper.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers._shared.response_helpers import (
    error_response as _error_response,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers._shared.resource_container import ResourceContainerManager

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# Config
# ------------------------------------------------------------------


@dataclass
class SearchServiceConfig:
    """Configuration that varies between Elasticsearch and OpenSearch."""

    service_name: str
    logger_name: str
    arn_service: str
    endpoint_suffix: str
    default_version: str
    default_instance_type: str
    version_field: str
    cluster_config_field: str
    action_map: dict[str, str]
    list_domain_extra: dict[str, str] = field(default_factory=dict)
    container_manager: ResourceContainerManager | None = None


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _Domain:
    """Represents a search-service domain."""

    def __init__(
        self,
        domain_name: str,
        version: str,
        cluster_config: dict[str, Any] | None,
        *,
        config: SearchServiceConfig,
    ) -> None:
        self.domain_name = domain_name
        self.version = version
        self.cluster_config: dict[str, Any] = cluster_config or {
            "InstanceType": config.default_instance_type,
            "InstanceCount": 1,
        }
        self.status = "active"
        self.arn = f"arn:aws:{config.arn_service}:{_REGION}:{_ACCOUNT_ID}:domain/{domain_name}"
        if config.data_plane_endpoint:
            self.endpoint = config.data_plane_endpoint
        else:
            self.endpoint = f"search-{domain_name}-local.{_REGION}.{config.endpoint_suffix}"
        self.tags: dict[str, str] = {}
        self.created = True
        self.processing = False


class _SearchState:
    """In-memory store for search-service domains."""

    def __init__(self) -> None:
        self.domains: dict[str, _Domain] = {}


# ------------------------------------------------------------------
# Format helpers
# ------------------------------------------------------------------


def _format_domain_status(domain: _Domain, config: SearchServiceConfig) -> dict[str, Any]:
    """Format a domain for API responses."""
    return {
        "DomainId": f"{_ACCOUNT_ID}/{domain.domain_name}",
        "DomainName": domain.domain_name,
        "ARN": domain.arn,
        "Created": domain.created,
        "Deleted": False,
        "Endpoint": domain.endpoint,
        "Processing": domain.processing,
        config.version_field: domain.version,
        config.cluster_config_field: domain.cluster_config,
        "AccessPolicies": "",
        "SnapshotOptions": {"AutomatedSnapshotStartHour": 0},
        "CognitoOptions": {"Enabled": False},
        "EncryptionAtRestOptions": {"Enabled": False},
        "NodeToNodeEncryptionOptions": {"Enabled": False},
        "AdvancedOptions": {
            "rest.action.multi.allow_explicit_index": "true",
        },
        "DomainEndpointOptions": {
            "EnforceHTTPS": False,
            "TLSSecurityPolicy": "Policy-Min-TLS-1-0-2019-07",
        },
    }


def _find_domain_by_arn(state: _SearchState, arn: str) -> _Domain | None:
    """Find a domain by its ARN."""
    for domain in state.domains.values():
        if domain.arn == arn:
            return domain
    return None


# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_create_domain(
    state: _SearchState, body: dict, config: SearchServiceConfig
) -> Response:
    domain_name = body.get("DomainName", "")
    if not domain_name:
        return _error_response("ValidationException", "DomainName is required.")

    if domain_name in state.domains:
        return _error_response(
            "ResourceAlreadyExistsException",
            f"Domain {domain_name} already exists.",
        )

    version = body.get(config.version_field, config.default_version)
    cluster_config = body.get(config.cluster_config_field, {})

    domain = _Domain(
        domain_name=domain_name,
        version=version,
        cluster_config=cluster_config if cluster_config else None,
        config=config,
    )

    tags_list = body.get("TagList", [])
    for tag in tags_list:
        domain.tags[tag["Key"]] = tag["Value"]

    state.domains[domain_name] = domain
    return _json_response({"DomainStatus": _format_domain_status(domain, config)})


async def _handle_describe_domain(
    state: _SearchState, body: dict, config: SearchServiceConfig
) -> Response:
    domain_name = body.get("DomainName", "")
    domain = state.domains.get(domain_name)
    if domain is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Domain {domain_name} not found.",
            status_code=409,
        )
    return _json_response({"DomainStatus": _format_domain_status(domain, config)})


async def _handle_describe_domains(
    state: _SearchState, body: dict, config: SearchServiceConfig
) -> Response:
    domain_names = body.get("DomainNames", [])
    domain_status_list = []
    for name in domain_names:
        domain = state.domains.get(name)
        if domain is not None:
            domain_status_list.append(_format_domain_status(domain, config))
    return _json_response({"DomainStatusList": domain_status_list})


async def _handle_delete_domain(
    state: _SearchState, body: dict, config: SearchServiceConfig
) -> Response:
    domain_name = body.get("DomainName", "")
    domain = state.domains.pop(domain_name, None)
    if domain is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Domain {domain_name} not found.",
            status_code=409,
        )
    domain.processing = True
    return _json_response({"DomainStatus": _format_domain_status(domain, config)})


async def _handle_list_domain_names(
    state: _SearchState, _body: dict, config: SearchServiceConfig
) -> Response:
    domain_names = [{"DomainName": name, **config.list_domain_extra} for name in state.domains]
    return _json_response({"DomainNames": domain_names})


async def _handle_list_tags(
    state: _SearchState, body: dict, _config: SearchServiceConfig
) -> Response:
    arn = body.get("ARN", "")
    domain = _find_domain_by_arn(state, arn)
    if domain is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Domain with ARN {arn} not found.",
        )
    tag_list = [{"Key": k, "Value": v} for k, v in domain.tags.items()]
    return _json_response({"TagList": tag_list})


async def _handle_add_tags(
    state: _SearchState, body: dict, _config: SearchServiceConfig
) -> Response:
    arn = body.get("ARN", "")
    tags_list = body.get("TagList", [])
    domain = _find_domain_by_arn(state, arn)
    if domain is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Domain with ARN {arn} not found.",
        )
    for tag in tags_list:
        domain.tags[tag["Key"]] = tag["Value"]
    return _json_response({})


async def _handle_remove_tags(
    state: _SearchState, body: dict, _config: SearchServiceConfig
) -> Response:
    arn = body.get("ARN", "")
    tag_keys = body.get("TagKeys", [])
    domain = _find_domain_by_arn(state, arn)
    if domain is None:
        return _error_response(
            "ResourceNotFoundException",
            f"Domain with ARN {arn} not found.",
        )
    for key in tag_keys:
        domain.tags.pop(key, None)
    return _json_response({})


# ------------------------------------------------------------------
# Generic handler names → implementation functions
# ------------------------------------------------------------------

_GENERIC_HANDLERS = {
    "CreateDomain": _handle_create_domain,
    "DescribeDomain": _handle_describe_domain,
    "DescribeDomains": _handle_describe_domains,
    "DeleteDomain": _handle_delete_domain,
    "ListDomainNames": _handle_list_domain_names,
    "ListTags": _handle_list_tags,
    "AddTags": _handle_add_tags,
    "RemoveTags": _handle_remove_tags,
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_search_service_app(config: SearchServiceConfig) -> FastAPI:
    """Create a FastAPI app that speaks a search-service wire protocol."""
    logger = get_logger(config.logger_name)
    app = FastAPI(title=f"LDK {config.service_name.title()}")
    app.add_middleware(RequestLoggingMiddleware, logger=logger, service_name=config.service_name)
    state = _SearchState()

    # Build action dispatch: map service-specific action names to handlers
    action_handlers: dict[str, Any] = {}
    for generic_name, handler in _GENERIC_HANDLERS.items():
        specific_name = config.action_map.get(generic_name, generic_name)
        action_handlers[specific_name] = handler

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = action_handlers.get(action)
        if handler is None:
            logger.warning("Unknown %s action: %s", config.service_name, action)
            return _error_response(
                "InvalidAction",
                f"lws: {config.service_name.title()} operation '{action}' is not yet implemented",
            )

        return await handler(state, body, config)

    return app
