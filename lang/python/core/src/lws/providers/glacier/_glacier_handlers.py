"""Glacier multipart upload, vault notification and job describe handlers.

These handlers are factored out of routes.py to keep file length below the
project's 500-line limit.
"""

from __future__ import annotations

import hashlib
import json
import uuid

from fastapi import Request, Response

from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity
from lws.providers._shared.response_helpers import (
    iso_now as _iso_now,
)
from lws.providers._shared.response_helpers import (
    json_response as _json_response,
)
from lws.providers.glacier._glacier_state import (
    _Archive,
    _archive_created_response,
    _archive_not_found_guard,
    _error_response,
    _format_job,
    _format_multipart_upload,
    _GlacierState,
    _Job,
    _MultipartUpload,
)

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


def _vault_not_found(vault_name: str) -> Response:
    return _error_response(
        "ResourceNotFoundException",
        f"Vault not found for ARN: arn:aws:glacier:{_REGION}:{_ACCOUNT_ID}:vaults/{vault_name}",
        status_code=404,
    )


async def handle_initiate_multipart_upload(
    state: _GlacierState,
    vault_name: str,
    request: Request,
) -> Response:
    """Handle InitiateMultipartUpload (POST /-/vaults/{vault_name}/multipart-uploads)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if vault.multipart_uploads:
        return _error_response(
            "InvalidParameterValueException",
            "A multipart upload is already in progress for this vault.",
        )

    part_size_header = request.headers.get("x-amz-part-size", "0")
    try:
        part_size = int(part_size_header)
    except ValueError:
        part_size = 0

    upload_id = str(uuid.uuid4())
    upload = _MultipartUpload(
        upload_id=upload_id,
        vault_name=vault_name,
        part_size=part_size,
    )
    vault.multipart_uploads[upload_id] = upload

    return Response(
        status_code=201,
        headers={
            "Location": f"/{_ACCOUNT_ID}/vaults/{vault_name}/multipart-uploads/{upload_id}",
            "x-amz-multipart-upload-id": upload_id,
        },
        media_type="application/x-amz-json-1.1",
    )


async def handle_upload_multipart_part(
    state: _GlacierState,
    vault_name: str,
    upload_id: str,
    request: Request,
) -> Response:
    """Handle UploadMultipartPart (PUT /-/vaults/{vault_name}/multipart-uploads/{upload_id})."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if upload_id not in vault.multipart_uploads:
        return _error_response(
            "ResourceNotFoundException",
            f"Upload not found: {upload_id}",
            status_code=404,
        )

    content_range = request.headers.get("Content-Range", "")
    body = await request.body()
    sha256_hash = hashlib.sha256(body).hexdigest()
    vault.multipart_uploads[upload_id].parts[content_range] = body

    return Response(
        status_code=204,
        headers={"x-amz-sha256-tree-hash": sha256_hash},
        media_type="application/x-amz-json-1.1",
    )


async def handle_complete_multipart_upload(
    state: _GlacierState,
    vault_name: str,
    upload_id: str,
    request: Request,
) -> Response:
    """Handle CompleteMultipartUpload.

    POST /-/vaults/{vault_name}/multipart-uploads/{upload_id}
    """
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if upload_id not in vault.multipart_uploads:
        return _error_response(
            "ResourceNotFoundException",
            f"Upload not found: {upload_id}",
            status_code=404,
        )

    upload = vault.multipart_uploads[upload_id]
    sorted_parts = sorted(upload.parts.items())
    assembled_body = b"".join(part_data for _, part_data in sorted_parts)
    sha256_hash = hashlib.sha256(assembled_body).hexdigest()
    archive_id = str(uuid.uuid4())
    description = request.headers.get("x-amz-archive-description", "")

    archive = _Archive(
        archive_id=archive_id,
        vault_name=vault_name,
        description=description,
        size=len(assembled_body),
        sha256_hash=sha256_hash,
        body=assembled_body,
    )
    vault.archives[archive_id] = archive
    del vault.multipart_uploads[upload_id]
    return _archive_created_response(vault_name, archive_id, sha256_hash)


async def handle_abort_multipart_upload(
    state: _GlacierState,
    vault_name: str,
    upload_id: str,
) -> Response:
    """Handle AbortMultipartUpload (DELETE /-/vaults/{vault_name}/multipart-uploads/{upload_id})."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if upload_id not in vault.multipart_uploads:
        return _error_response(
            "ResourceNotFoundException",
            f"Upload not found: {upload_id}",
            status_code=404,
        )

    del vault.multipart_uploads[upload_id]
    return Response(status_code=204)


async def handle_list_multipart_uploads(
    state: _GlacierState,
    vault_name: str,
) -> Response:
    """Handle ListMultipartUploads (GET /-/vaults/{vault_name}/multipart-uploads)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    upload_list = [_format_multipart_upload(u) for u in vault.multipart_uploads.values()]
    return _json_response({"UploadsList": upload_list})


async def handle_list_parts(
    state: _GlacierState,
    vault_name: str,
    upload_id: str,
) -> Response:
    """Handle ListParts (GET /-/vaults/{vault_name}/multipart-uploads/{upload_id})."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if upload_id not in vault.multipart_uploads:
        return _error_response(
            "ResourceNotFoundException",
            f"Upload not found: {upload_id}",
            status_code=404,
        )

    upload = vault.multipart_uploads[upload_id]
    parts_list = [
        {
            "RangeInBytes": content_range,
            "SHA256TreeHash": hashlib.sha256(part_data).hexdigest(),
        }
        for content_range, part_data in sorted(upload.parts.items())
    ]

    return _json_response(
        {
            "ArchiveDescription": "",
            "CreationDate": upload.created_date,
            "MultipartUploadId": upload_id,
            "PartSizeInBytes": upload.part_size,
            "Parts": parts_list,
            "VaultARN": vault.arn,
        }
    )


async def handle_set_vault_notifications(
    state: _GlacierState,
    vault_name: str,
    request: Request,
) -> Response:
    """Handle SetVaultNotifications (PUT /-/vaults/{vault_name}/notification-configuration)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    body = await request.body()
    try:
        config = json.loads(body) if body else {}
    except json.JSONDecodeError:
        config = {}

    state.vaults[vault_name].notification_config = config
    return Response(status_code=204)


async def handle_get_vault_notifications(
    state: _GlacierState,
    vault_name: str,
) -> Response:
    """Handle GetVaultNotifications (GET /-/vaults/{vault_name}/notification-configuration)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if vault.notification_config is None:
        return _error_response(
            "ResourceNotFoundException",
            f"No notification configuration set for vault: {vault_name}",
            status_code=404,
        )

    return _json_response({"VaultNotificationConfig": vault.notification_config})


async def handle_delete_vault_notifications(
    state: _GlacierState,
    vault_name: str,
) -> Response:
    """Handle DeleteVaultNotifications.

    DELETE /-/vaults/{vault_name}/notification-configuration
    """
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    state.vaults[vault_name].notification_config = None
    return Response(status_code=204)


async def handle_describe_job(
    state: _GlacierState,
    vault_name: str,
    job_id: str,
) -> Response:
    """Handle DescribeJob (GET /-/vaults/{vault_name}/jobs/{job_id})."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    if job_id not in vault.jobs:
        return _error_response(
            "ResourceNotFoundException",
            f"Job not found: {job_id}",
            status_code=404,
        )

    job = vault.jobs[job_id]
    return _json_response(_format_job(job))


async def handle_initiate_job(
    state: _GlacierState,
    vault_name: str,
    request: Request,
    capacity: AwsCapacityConfig | None = None,
) -> Response:
    """Handle InitiateJob (POST /-/vaults/{vaultName}/jobs)."""
    if capacity is not None:
        cap_err = check_capacity(capacity, "ServiceUnavailableException", 503)
        if cap_err is not None:
            return cap_err
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    body = await request.body()
    try:
        job_params = json.loads(body) if body else {}
    except json.JSONDecodeError:
        job_params = {}

    action = job_params.get("Type", "inventory-retrieval")
    archive_id = job_params.get("ArchiveId")

    if action == "archive-retrieval" and archive_id:
        vault = state.vaults[vault_name]
        guard = _archive_not_found_guard(vault, archive_id)
        if guard is not None:
            return guard

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


async def handle_list_jobs(state: _GlacierState, vault_name: str) -> Response:
    """Handle ListJobs (GET /-/vaults/{vaultName}/jobs)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

    vault = state.vaults[vault_name]
    job_list = [_format_job(j) for j in vault.jobs.values()]
    return _json_response({"JobList": job_list})


async def handle_get_job_output(
    state: _GlacierState,
    vault_name: str,
    job_id: str,
) -> Response:
    """Handle GetJobOutput (GET /-/vaults/{vaultName}/jobs/{jobId}/output)."""
    if vault_name not in state.vaults:
        return _vault_not_found(vault_name)

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
