"""IAM auth management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import Request
from fastapi.responses import JSONResponse


def _handle_get_iam_auth(iam_auth_bundle: Any) -> JSONResponse:
    """Return current IAM auth config."""
    if iam_auth_bundle is None:
        return JSONResponse(content={"enabled": False})
    return JSONResponse(content=_serialize_iam_auth_config(iam_auth_bundle.config))


async def _handle_set_iam_auth(request: Request, iam_auth_bundle: Any) -> JSONResponse:
    """Update IAM auth config at runtime."""
    if iam_auth_bundle is None:
        return JSONResponse(content={"error": "IAM auth not configured"}, status_code=400)
    body = await request.json()
    config = iam_auth_bundle.config
    if "mode" in body:
        config.mode = body["mode"]
    if "default_identity" in body:
        config.default_identity = body["default_identity"]
    from lws.config.loader import IamAuthServiceConfig  # pylint: disable=import-outside-toplevel

    for svc, overrides in body.get("services", {}).items():
        if svc not in config.services:
            config.services[svc] = IamAuthServiceConfig()
        svc_cfg = config.services[svc]
        if "mode" in overrides:
            svc_cfg.mode = overrides["mode"]
        if "enabled" in overrides:
            svc_cfg.enabled = overrides["enabled"]
    for name, identity_def in body.get("identities", {}).items():
        iam_auth_bundle.identity_store.register_identity(
            name=name,
            inline_policies=identity_def.get("inline_policies", []),
            boundary_policy=identity_def.get("boundary_policy"),
        )
    return JSONResponse(content={"config": _serialize_iam_auth_config(config)})


def _serialize_iam_auth_config(config: Any) -> dict[str, Any]:
    """Serialize an IamAuthConfig to a JSON-safe dict."""
    return {
        "mode": config.mode,
        "default_identity": config.default_identity,
        "identity_header": config.identity_header,
        "services": {
            svc: {"mode": svc_cfg.mode, "enabled": svc_cfg.enabled}
            for svc, svc_cfg in config.services.items()
        },
    }
