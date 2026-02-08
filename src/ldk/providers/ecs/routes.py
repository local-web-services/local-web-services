"""FastAPI route definitions for ECS service management.

Provides routes for querying ECS service status, triggering restarts,
and inspecting the service discovery registry.
"""

from __future__ import annotations

from fastapi import APIRouter

from ldk.providers.ecs.discovery import ServiceRegistry

router = APIRouter(prefix="/ecs", tags=["ecs"])


def build_ecs_router(registry: ServiceRegistry) -> APIRouter:
    """Create an API router that exposes ECS service management endpoints.

    Args:
        registry: The service discovery registry to query.

    Returns:
        A FastAPI ``APIRouter`` with ECS management routes.
    """
    ecs_router = APIRouter(prefix="/ecs", tags=["ecs"])

    @ecs_router.get("/services")
    async def list_services() -> dict:
        endpoints = registry.all_endpoints()
        services = []
        for name, ep in endpoints.items():
            services.append(
                {
                    "service_name": name,
                    "host": ep.host,
                    "port": ep.port,
                    "url": ep.url,
                }
            )
        return {"services": services}

    @ecs_router.get("/services/{service_name}")
    async def get_service(service_name: str) -> dict:
        ep = registry.lookup(service_name)
        if ep is None:
            return {"error": f"Service '{service_name}' not found"}
        return {
            "service_name": ep.service_name,
            "host": ep.host,
            "port": ep.port,
            "url": ep.url,
        }

    return ecs_router
