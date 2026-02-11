"""Glacier HTTP routes.

Implements the Glacier REST API wire protocol that AWS SDKs and Terraform use,
using path-based routing with JSON request/response format.
"""

from __future__ import annotations

import hashlib
import json
import uuid
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.response_helpers import (
    error_response as _error_response_base,
)
from lws.providers._shared.response_helpers import (
    iso_now as _iso_now,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)

_logger = get_logger("ldk.glacier")

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


# ------------------------------------------------------------------
# In-memory state
# ------------------------------------------------------------------


class _Archive:
    """Represents a Glacier archive."""

    def __init__(
        self,
        archive_id: str,
        vault_name: str,
        description: str,
        size: int,
        sha256_hash: str,
        body: bytes,
    ) -> None:
        self.archive_id = archive_id
        self.vault_name = vault_name
        self.description = description
        self.size = size
        self.sha256_hash = sha256_hash
        self.body = body
        self.created_date = _iso_now()


class _Job:
    """Represents a Glacier job."""

    def __init__(
        self,
        job_id: str,
        vault_name: str,
        action: str,
        archive_id: str | None = None,
    ) -> None:
        self.job_id = job_id
        self.vault_name = vault_name
        self.action = action
        self.status = "Succeeded"
        self.archive_id = archive_id
        self.created_date = _iso_now()
        self.completed_date = _iso_now()


class _Vault:
    """Represents a Glacier vault."""

    def __init__(self, vault_name: str) -> None:
        self.vault_name = vault_name
        self.arn = f"arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}"
        self.created_date = _iso_now()
        self.archives: dict[str, _Archive] = {}
        self.jobs: dict[str, _Job] = {}

    @property
    def size_in_bytes(self) -> int:
        """Return the total size of all archives in the vault."""
        return sum(a.size for a in self.archives.values())

    @property
    def number_of_archives(self) -> int:
        """Return the number of archives in the vault."""
        return len(self.archives)


class _GlacierState:
    """In-memory store for Glacier vaults."""

    def __init__(self) -> None:
        self._vaults: dict[str, _Vault] = {}

    @property
    def vaults(self) -> dict[str, _Vault]:
        """Return the vaults store."""
        return self._vaults


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _error_response(code: str, message: str, status_code: int = 400) -> Response:
    """Return an error response in Glacier format (lowercase 'message' key)."""
    return _error_response_base(code, message, status_code=status_code, message_key="message")


def _format_vault(vault: _Vault) -> dict[str, Any]:
    """Format a vault for API response."""
    return {
        "CreationDate": vault.created_date,
        "LastInventoryDate": vault.created_date,
        "NumberOfArchives": vault.number_of_archives,
        "SizeInBytes": vault.size_in_bytes,
        "VaultARN": vault.arn,
        "VaultName": vault.vault_name,
    }


def _format_job(job: _Job) -> dict[str, Any]:
    """Format a job for API response."""
    result: dict[str, Any] = {
        "Action": job.action,
        "Completed": job.status == "Succeeded",
        "CompletionDate": job.completed_date,
        "CreationDate": job.created_date,
        "JobId": job.job_id,
        "StatusCode": job.status,
        "StatusMessage": "Succeeded" if job.status == "Succeeded" else "InProgress",
        "VaultARN": f"arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{job.vault_name}",
    }
    if job.archive_id is not None:
        result["ArchiveId"] = job.archive_id
    return result


# ------------------------------------------------------------------
# Route handlers
# ------------------------------------------------------------------


async def _create_vault(state: _GlacierState, vault_name: str) -> Response:
    """Handle CreateVault (PUT /-/vaults/{vaultName})."""
    if vault_name not in state.vaults:
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
) -> Response:
    """Handle UploadArchive (POST /-/vaults/{vaultName}/archives)."""
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

    return Response(
        status_code=201,
        headers={
            "Location": f"/{_ACCOUNT_ID}/vaults/{vault_name}/archives/{archive_id}",
            "x-amz-archive-id": archive_id,
            "x-amz-sha256-tree-hash": sha256_hash,
        },
        media_type="application/x-amz-json-1.1",
    )


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
    if archive_id not in vault.archives:
        return _error_response(
            "ResourceNotFoundException",
            f"Archive not found: {archive_id}",
            status_code=404,
        )

    del vault.archives[archive_id]
    return Response(status_code=204)


async def _initiate_job(
    state: _GlacierState,
    vault_name: str,
    request: Request,
) -> Response:
    """Handle InitiateJob (POST /-/vaults/{vaultName}/jobs)."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    body = await request.body()
    try:
        job_params = json.loads(body) if body else {}
    except json.JSONDecodeError:
        job_params = {}

    action = job_params.get("Type", "inventory-retrieval")
    archive_id = job_params.get("ArchiveId")

    if action == "archive-retrieval" and archive_id:
        vault = state.vaults[vault_name]
        if archive_id not in vault.archives:
            return _error_response(
                "ResourceNotFoundException",
                f"Archive not found: {archive_id}",
                status_code=404,
            )

    job_id = str(uuid.uuid4())
    job = _Job(
        job_id=job_id,
        vault_name=vault_name,
        action=action,
        archive_id=archive_id,
    )
    state.vaults[vault_name].jobs[job_id] = job

    return Response(
        status_code=202,
        headers={
            "Location": f"/{_ACCOUNT_ID}/vaults/{vault_name}/jobs/{job_id}",
            "x-amz-job-id": job_id,
        },
        media_type="application/x-amz-json-1.1",
    )


async def _list_jobs(state: _GlacierState, vault_name: str) -> Response:
    """Handle ListJobs (GET /-/vaults/{vaultName}/jobs)."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    job_list = [_format_job(j) for j in vault.jobs.values()]
    return _json_response({"JobList": job_list})


async def _get_job_output(
    state: _GlacierState,
    vault_name: str,
    job_id: str,
) -> Response:
    """Handle GetJobOutput (GET /-/vaults/{vaultName}/jobs/{jobId}/output)."""
    if vault_name not in state.vaults:
        return _error_response(
            "ResourceNotFoundException",
            f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
            status_code=404,
        )

    vault = state.vaults[vault_name]
    if job_id not in vault.jobs:
        return _error_response(
            "ResourceNotFoundException",
            f"Job not found: {job_id}",
            status_code=404,
        )

    job = vault.jobs[job_id]

    if job.status != "Succeeded":
        return _error_response(
            "InvalidParameterValueException",
            "The job is not yet completed.",
        )

    if job.action == "inventory-retrieval":
        archive_list = [
            {
                "ArchiveId": a.archive_id,
                "ArchiveDescription": a.description,
                "CreationDate": a.created_date,
                "Size": a.size,
                "SHA256TreeHash": a.sha256_hash,
            }
            for a in vault.archives.values()
        ]
        inventory = {
            "VaultARN": vault.arn,
            "InventoryDate": _iso_now(),
            "ArchiveList": archive_list,
        }
        return _json_response(inventory)

    if job.action == "archive-retrieval":
        if job.archive_id is None:
            return _error_response(
                "InvalidParameterValueException",
                "No archive ID associated with this job.",
            )

        archive = vault.archives.get(job.archive_id)
        if archive is None:
            return _error_response(
                "ResourceNotFoundException",
                f"Archive not found: {job.archive_id}",
                status_code=404,
            )

        return Response(
            content=archive.body,
            status_code=200,
            media_type="application/octet-stream",
            headers={
                "x-amz-sha256-tree-hash": archive.sha256_hash,
                "Content-Length": str(archive.size),
            },
        )

    return _error_response(
        "InvalidParameterValueException",
        f"Unsupported job action: {job.action}",
    )


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_glacier_app() -> FastAPI:
    """Create a FastAPI application that speaks the Glacier REST wire protocol."""
    app = FastAPI(title="LDK Glacier")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="glacier")
    state = _GlacierState()

    @app.put("/-/vaults/{vault_name}")
    async def create_vault(vault_name: str) -> Response:
        return await _create_vault(state, vault_name)

    @app.delete("/-/vaults/{vault_name}")
    async def delete_vault(vault_name: str) -> Response:
        return await _delete_vault(state, vault_name)

    @app.get("/-/vaults/{vault_name}")
    async def describe_vault(vault_name: str) -> Response:
        return await _describe_vault(state, vault_name)

    @app.get("/-/vaults")
    async def list_vaults() -> Response:
        return await _list_vaults(state)

    @app.post("/-/vaults/{vault_name}/archives")
    async def upload_archive(vault_name: str, request: Request) -> Response:
        return await _upload_archive(state, vault_name, request)

    @app.delete("/-/vaults/{vault_name}/archives/{archive_id}")
    async def delete_archive(vault_name: str, archive_id: str) -> Response:
        return await _delete_archive(state, vault_name, archive_id)

    @app.post("/-/vaults/{vault_name}/jobs")
    async def initiate_job(vault_name: str, request: Request) -> Response:
        return await _initiate_job(state, vault_name, request)

    @app.get("/-/vaults/{vault_name}/jobs")
    async def list_jobs(vault_name: str) -> Response:
        return await _list_jobs(state, vault_name)

    @app.get("/-/vaults/{vault_name}/jobs/{job_id}/output")
    async def get_job_output(vault_name: str, job_id: str) -> Response:
        return await _get_job_output(state, vault_name, job_id)

    return app
