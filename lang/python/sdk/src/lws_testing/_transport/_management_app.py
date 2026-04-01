"""Factory for the LWS testing management FastAPI app."""

from __future__ import annotations

from typing import Any

from lws_testing._transport._provider_wrappers import _StubOrchestrator


def _create_management_app(
    providers: dict[str, Any],
    chaos_configs: dict[str, Any],
    fake_configs: dict[str, Any],
    lifecycle_configs: dict[str, Any],
    capacity_configs: dict[str, Any] | None = None,
    fake_provider: Any | None = None,
    state_store: Any | None = None,
    tracker_registry: dict | None = None,
) -> Any:
    """Build a FastAPI management app with reset, fake, chaos, lifecycle, and capacity endpoints."""
    from fastapi import FastAPI
    from fastapi.responses import JSONResponse
    from lws.api.management import _handle_reset, create_management_router
    from lws.providers._shared.capacity_control import create_capacity_control_router

    orchestrator = _StubOrchestrator(providers)
    app = FastAPI(title="LWS Testing Management")

    router = create_management_router(
        orchestrator=orchestrator,
        providers=providers,
        chaos_configs=chaos_configs,
        aws_fake_configs=fake_configs,
        lifecycle_configs=lifecycle_configs,
        capacity_configs=capacity_configs,
        fake_provider=fake_provider,
        state_store=state_store,
        tracker_registry=tracker_registry,
    )
    app.include_router(router)
    app.include_router(create_capacity_control_router(capacity_configs or {}))

    # Alias endpoint used by LwsSession.reset()
    @app.post("/_ldk/state/clear")
    async def state_clear() -> JSONResponse:
        return await _handle_reset(providers, state_store=state_store)

    # CloudTrail flush endpoint — triggers an immediate S3 delivery flush
    cloudtrail_provider = providers.get("cloudtrail")
    if cloudtrail_provider is not None:

        @app.post("/_ldk/cloudtrail/flush")
        async def cloudtrail_flush() -> JSONResponse:
            if cloudtrail_provider._delivery is not None:  # pylint: disable=protected-access
                await cloudtrail_provider._delivery.flush_now()  # pylint: disable=protected-access
            return JSONResponse(content={"flushed": True})

    return app
