"""Control plane router for forcing resource lifecycle states in tests.

Exposes ``PUT /_lws/control/{service}/{resource_type}/{resource_id}/lifecycle``
to force a resource into any lifecycle state and freeze it there, and
``DELETE`` on the same URL to unfreeze and resume the pending transition.
"""

from __future__ import annotations

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_lifecycle import ResourceStateTracker


def create_lifecycle_control_router(
    trackers: dict[str, dict[str, ResourceStateTracker]],
) -> APIRouter:
    """Create an APIRouter with lifecycle control endpoints.

    Args:
        trackers: Nested mapping of ``{service: {resource_type: tracker}}``.

    Returns:
        An ``APIRouter`` ready to include in a FastAPI app.
    """
    router = APIRouter()

    @router.put("/_lws/control/{service}/{resource_type}/{resource_id}/lifecycle")
    async def force_lifecycle_state(
        service: str,
        resource_type: str,
        resource_id: str,
        request: Request,
    ) -> JSONResponse:
        tracker = _resolve_tracker(trackers, service, resource_type)
        if tracker is None:
            return JSONResponse(
                content={"error": f"No tracker registered for {service}/{resource_type}"},
                status_code=404,
            )
        body = await request.json()
        state = body.get("state")
        if not state:
            return JSONResponse(
                content={"error": "Request body must include 'state'"},
                status_code=400,
            )
        tracker.set_state(resource_id, state, frozen=True)
        return JSONResponse(
            content={
                "service": service,
                "resource_type": resource_type,
                "resource_id": resource_id,
                "state": state,
                "frozen": True,
            }
        )

    @router.delete("/_lws/control/{service}/{resource_type}/{resource_id}/lifecycle")
    async def unfreeze_lifecycle_state(
        service: str,
        resource_type: str,
        resource_id: str,
    ) -> JSONResponse:
        tracker = _resolve_tracker(trackers, service, resource_type)
        if tracker is None:
            return JSONResponse(
                content={"error": f"No tracker registered for {service}/{resource_type}"},
                status_code=404,
            )
        tracker.unfreeze(resource_id, apply=True)
        return JSONResponse(
            content={
                "service": service,
                "resource_type": resource_type,
                "resource_id": resource_id,
                "frozen": False,
            }
        )

    return router


def _resolve_tracker(
    trackers: dict[str, dict[str, ResourceStateTracker]],
    service: str,
    resource_type: str,
) -> ResourceStateTracker | None:
    """Look up a tracker by service and resource type."""
    service_trackers = trackers.get(service)
    if service_trackers is None:
        return None
    return service_trackers.get(resource_type)
