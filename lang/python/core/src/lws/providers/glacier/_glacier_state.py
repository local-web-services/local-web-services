"""In-memory state classes and helper formatters for the Glacier provider."""

from __future__ import annotations

from typing import Any

from fastapi import Response

from lws.providers._shared.response_helpers import (
    error_response as _error_response_base,
)
from lws.providers._shared.response_helpers import iso_now as _iso_now

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

    def reset(self) -> None:
        """Clear all vaults, archives, and jobs."""
        self._vaults.clear()


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
