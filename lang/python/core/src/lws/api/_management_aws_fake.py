"""AWS fake management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_operation_fake import AwsFakeConfig


def _handle_get_aws_fake(fake_configs: dict[str, AwsFakeConfig]) -> JSONResponse:
    """Return current AWS fake config for all services."""
    result = {svc: _serialize_aws_fake(cfg) for svc, cfg in fake_configs.items()}
    return JSONResponse(content=result)


async def _handle_set_aws_fake(
    request: Request, fake_configs: dict[str, AwsFakeConfig]
) -> JSONResponse:
    """Update AWS fake config for one or more services."""
    body = await request.json()
    updated: list[str] = []
    for svc, overrides in body.items():
        if svc not in fake_configs:
            continue
        _apply_aws_fake_overrides(fake_configs[svc], overrides)
        updated.append(svc)
    result = {svc: _serialize_aws_fake(fake_configs[svc]) for svc in updated}
    return JSONResponse(content={"updated": updated, "aws_fake": result})


def _serialize_aws_fake(cfg: AwsFakeConfig) -> dict[str, Any]:
    """Serialize an AwsFakeConfig to a JSON-safe dict."""
    return {
        "service": cfg.service,
        "enabled": cfg.enabled,
        "rules": [
            {
                "operation": r.operation,
                "match_headers": r.match_headers,
                "response": {
                    "status": r.response.status,
                    "content_type": r.response.content_type,
                    "delay_ms": r.response.delay_ms,
                },
            }
            for r in cfg.rules
        ],
    }


def _apply_aws_fake_overrides(cfg: AwsFakeConfig, overrides: dict[str, Any]) -> None:
    """Apply partial overrides to an existing AwsFakeConfig in place."""
    from lws.providers._shared.aws_operation_fake import (  # pylint: disable=import-outside-toplevel
        parse_fake_rule,
    )

    if "enabled" in overrides:
        cfg.enabled = bool(overrides["enabled"])
    if "rules" in overrides:
        cfg.rules = [parse_fake_rule(r) for r in overrides["rules"]]
