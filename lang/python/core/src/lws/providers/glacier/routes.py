"""Glacier HTTP routes.

Implements the Glacier REST API wire protocol that AWS SDKs and Terraform use,
using path-based routing with JSON request/response format.
"""

from __future__ import annotations

import hashlib
import uuid

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.provider_context import ProviderContext
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers.glacier._glacier_handlers import (
    handle_abort_multipart_upload as _abort_multipart_upload,
)
from lws.providers.glacier._glacier_handlers import (
    handle_complete_multipart_upload as _complete_multipart_upload,
)
from lws.providers.glacier._glacier_handlers import (
    handle_delete_vault_notifications as _delete_vault_notifications,
)
from lws.providers.glacier._glacier_handlers import (
    handle_describe_job as _describe_job,
)
from lws.providers.glacier._glacier_handlers import (
    handle_get_job_output as _get_job_output,
)
from lws.providers.glacier._glacier_handlers import (
    handle_get_vault_notifications as _get_vault_notifications,
)
from lws.providers.glacier._glacier_handlers import (
    handle_initiate_job as _initiate_job,
)
from lws.providers.glacier._glacier_handlers import (
    handle_initiate_multipart_upload as _initiate_multipart_upload,
)
from lws.providers.glacier._glacier_handlers import (
    handle_list_jobs as _list_jobs,
)
from lws.providers.glacier._glacier_handlers import (
    handle_list_multipart_uploads as _list_multipart_uploads,
)
from lws.providers.glacier._glacier_handlers import (
    handle_list_parts as _list_parts,
)
from lws.providers.glacier._glacier_handlers import (
    handle_set_vault_notifications as _set_vault_notifications,
)
from lws.providers.glacier._glacier_handlers import (
    handle_upload_multipart_part as _upload_multipart_part,
)
from lws.providers.glacier._glacier_state import (
    _Archive,
    _archive_created_response,
    _archive_not_found_guard,
    _error_response,
    _format_vault,
    _GlacierState,
    _Vault,
)

_logger = get_logger("ldk.glacier")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# Route handlers
# ------------------------------------------------------------------


async def _create_vault(state: _GlacierState, vault_name: str) -> Response:
    """Handle CreateVault (PUT /-/vaults/{vaultName})."""
    if vault_name in state.vaults:
        return _error_response(
            "ResourceInUseException",
            f"Vault with name '{vault_name}' already exists",
            status_code=409,
        )
    state.vaults[vault_name] = _Vault(vault_name)

    return Response(
        status_code=201,
        headers={
            "Location": f"/{_ACCOUNT_ID}/vaults/{vault_name}",
            "x-amzn-RequestId": str(uuid.uuid4()),
        },
        media_type="application/x-amz-json-1.1",
    )


async def _delete_vault(state: _GlacierState, vault_name: str) -> Response:
    """Handle DeleteVault (DELETE /-/vaults/{vaultName})."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    if vault.number_of_archives > 0:
        return _error_response(
            "InvalidParameterValueException",
            "The vault is not empty. Delete all archives before deleting the vault.",
        )

    del state.vaults[vault_name]
    return Response(status_code=204)


async def _describe_vault(state: _GlacierState, vault_name: str) -> Response:
    """Handle DescribeVault (GET /-/vaults/{vaultName})."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    return _json_response(_format_vault(vault))


async def _list_vaults(state: _GlacierState) -> Response:
    """Handle ListVaults (GET /-/vaults)."""
    vault_list = [_format_vault(v) for v in state.vaults.values()]
    return _json_response({"VaultList": vault_list})


async def _upload_archive(
    state: _GlacierState,
    vault_name: str,
    request: Request,
    capacity: AwsCapacityConfig | None = None,
) -> Response:
    """Handle UploadArchive (POST /-/vaults/{vaultName}/archives)."""
    if capacity is not None:
        cap_err = check_capacity(capacity, "ServiceUnavailableException", 503)
        if cap_err is not None:
            return cap_err
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    body = await request.body()
    description = request.headers.get("x-amz-archive-description", "")
    sha256_hash = hashlib.sha256(body).hexdigest()
    archive_id = str(uuid.uuid4())

    archive = _Archive(
        archive_id=archive_id,
        vault_name=vault_name,
        description=description,
        size=len(body),
        sha256_hash=sha256_hash,
        body=body,
    )
    vault.archives[archive_id] = archive
    return _archive_created_response(vault_name, archive_id, sha256_hash)


async def _delete_archive(
    state: _GlacierState,
    vault_name: str,
    archive_id: str,
) -> Response:
    """Handle DeleteArchive (DELETE /-/vaults/{vaultName}/archives/{archiveId})."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    guard = _archive_not_found_guard(vault, archive_id)
    if guard is not None:
        return guard
    del vault.archives[archive_id]
    return Response(status_code=204)


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


async def _lifecycle_create_vault(
    state: _GlacierState,
    vault_name: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    resp = await _create_vault(state, vault_name)
    if lc.enabled and resp.status_code == 201:
        tracker.set_state(vault_name, "CREATING")
        tracker.schedule_transition(vault_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_vault(
    state: _GlacierState,
    vault_name: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    if lc.enabled and tracker.get_state(vault_name) == "CREATING":
        return _error_response(
            "InvalidParameterValueException",
            f"Vault {vault_name} is still being created",
        )
    resp = await _delete_vault(state, vault_name)
    if lc.enabled and resp.status_code == 204:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(vault_name, "DELETING")
            tracker.schedule_transition(vault_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(vault_name)
    return resp


async def _lifecycle_describe_vault(
    state: _GlacierState,
    vault_name: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    if lc.enabled:
        vault_state = tracker.get_state(vault_name)
        if vault_state in ("CREATING", "DELETING"):
            arn = f"arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}"
            return _error_response(
                "ResourceNotFoundException",
                f"Vault not found for ARN: {arn} (status: {vault_state})",
                status_code=404,
            )
    return await _describe_vault(state, vault_name)


def _register_vault_crud_routes(
    app: FastAPI,
    state: _GlacierState,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    capacity: AwsCapacityConfig,
) -> None:
    """Register vault CRUD and archive routes on *app*."""

    @app.put("/-/vaults/{vault_name}")
    async def create_vault(vault_name: str) -> Response:
        return await _lifecycle_create_vault(state, vault_name, lc, tracker)

    @app.delete("/-/vaults/{vault_name}")
    async def delete_vault(vault_name: str) -> Response:
        return await _lifecycle_delete_vault(state, vault_name, lc, tracker)

    @app.get("/-/vaults/{vault_name}")
    async def describe_vault(vault_name: str) -> Response:
        return await _lifecycle_describe_vault(state, vault_name, lc, tracker)

    @app.get("/-/vaults")
    async def list_vaults() -> Response:
        return await _list_vaults(state)

    @app.post("/-/vaults/{vault_name}/archives")
    async def upload_archive(vault_name: str, request: Request) -> Response:
        return await _upload_archive(state, vault_name, request, capacity)

    @app.delete("/-/vaults/{vault_name}/archives/{archive_id}")
    async def delete_archive(vault_name: str, archive_id: str) -> Response:
        return await _delete_archive(state, vault_name, archive_id)


def _register_job_routes(
    app: FastAPI,
    state: _GlacierState,
    capacity: AwsCapacityConfig,
) -> None:
    """Register vault job routes on *app*."""

    @app.post("/-/vaults/{vault_name}/jobs")
    async def initiate_job(vault_name: str, request: Request) -> Response:
        return await _initiate_job(state, vault_name, request, capacity)

    @app.get("/-/vaults/{vault_name}/jobs")
    async def list_jobs(vault_name: str) -> Response:
        return await _list_jobs(state, vault_name)

    @app.get("/-/vaults/{vault_name}/jobs/{job_id}/output")
    async def get_job_output(vault_name: str, job_id: str) -> Response:
        return await _get_job_output(state, vault_name, job_id)

    @app.get("/-/vaults/{vault_name}/jobs/{job_id}")
    async def describe_job(vault_name: str, job_id: str) -> Response:
        return await _describe_job(state, vault_name, job_id)


async def _complete_multipart_upload_with_capacity(
    state: _GlacierState,
    vault_name: str,
    upload_id: str,
    request: Request,
    capacity: AwsCapacityConfig,
) -> Response:
    """Complete a multipart upload with capacity check."""
    cap_err = check_capacity(capacity, "ServiceUnavailableException", 503)
    if cap_err is not None:
        return cap_err
    return await _complete_multipart_upload(state, vault_name, upload_id, request)


def _register_multipart_routes(
    app: FastAPI,
    state: _GlacierState,
    capacity: AwsCapacityConfig | None = None,
) -> None:
    """Register multipart-upload routes on *app*."""

    @app.post("/-/vaults/{vault_name}/multipart-uploads")
    async def initiate_multipart_upload(vault_name: str, request: Request) -> Response:
        return await _initiate_multipart_upload(state, vault_name, request)

    @app.put("/-/vaults/{vault_name}/multipart-uploads/{upload_id}")
    async def upload_multipart_part(vault_name: str, upload_id: str, request: Request) -> Response:
        return await _upload_multipart_part(state, vault_name, upload_id, request)

    @app.post("/-/vaults/{vault_name}/multipart-uploads/{upload_id}")
    async def complete_multipart_upload(
        vault_name: str, upload_id: str, request: Request
    ) -> Response:
        if capacity is not None:
            return await _complete_multipart_upload_with_capacity(
                state, vault_name, upload_id, request, capacity
            )
        return await _complete_multipart_upload(state, vault_name, upload_id, request)

    @app.delete("/-/vaults/{vault_name}/multipart-uploads/{upload_id}")
    async def abort_multipart_upload(vault_name: str, upload_id: str) -> Response:
        return await _abort_multipart_upload(state, vault_name, upload_id)

    @app.get("/-/vaults/{vault_name}/multipart-uploads")
    async def list_multipart_uploads(vault_name: str) -> Response:
        return await _list_multipart_uploads(state, vault_name)

    @app.get("/-/vaults/{vault_name}/multipart-uploads/{upload_id}")
    async def list_parts(vault_name: str, upload_id: str) -> Response:
        return await _list_parts(state, vault_name, upload_id)


def _register_notification_routes(app: FastAPI, state: _GlacierState) -> None:
    """Register vault-notification routes on *app*."""

    @app.put("/-/vaults/{vault_name}/notification-configuration")
    async def set_vault_notifications(vault_name: str, request: Request) -> Response:
        return await _set_vault_notifications(state, vault_name, request)

    @app.get("/-/vaults/{vault_name}/notification-configuration")
    async def get_vault_notifications(vault_name: str) -> Response:
        return await _get_vault_notifications(state, vault_name)

    @app.delete("/-/vaults/{vault_name}/notification-configuration")
    async def delete_vault_notifications(vault_name: str) -> Response:
        return await _delete_vault_notifications(state, vault_name)


def create_glacier_app(
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    context: ProviderContext | None = None,
) -> tuple[FastAPI, _GlacierState]:
    """Create a FastAPI application that speaks the Glacier REST wire protocol."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)
    _capacity = capacity or AwsCapacityConfig()

    app = FastAPI(title="LDK Glacier")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="glacier")
    state = _GlacierState()

    _register_vault_crud_routes(app, state, _lc, _tracker, _capacity)
    _register_job_routes(app, state, _capacity)
    _register_multipart_routes(app, state, _capacity)
    _register_notification_routes(app, state)

    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "glacier")
    return app, state
