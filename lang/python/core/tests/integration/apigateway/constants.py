"""Constants and shared helpers."""

from __future__ import annotations

INT_API_NAME = "int-api-1"

INT_API_NAME_DEV = "int-api-dev-1"

INT_API_NAME_PROD = "int-api-prod-1"

INT_RESOURCE_PATH = "int-items"

INT_HTTP_METHOD = "GET"

INT_INTEGRATION_TYPE = "AWS_PROXY"

INT_STAGE_DEV = "dev"

INT_STAGE_PROD = "prod"

INT_STATUS_CODE = "200"

_API_DELETED_STEP = (
    'the "API" is "DELETED" along with all its resources, '
    "methods, integrations, deployments, and stages"
)
