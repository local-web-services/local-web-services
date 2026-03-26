"""Test client for glacier tests."""

from __future__ import annotations

from .constants import INT_ARCHIVE_BODY, INT_VAULT_NAME


class GlacierTestClient:
    def __init__(self, client):
        self._client = client

    def create_vault(self, vault_name: str = INT_VAULT_NAME) -> None:
        self._client.put(f"/-/vaults/{vault_name}")

    def upload_archive(
        self, vault_name: str = INT_VAULT_NAME, body: bytes = INT_ARCHIVE_BODY
    ) -> str:
        r = self._client.post(f"/-/vaults/{vault_name}/archives", content=body)
        return r.headers.get("x-amz-archive-id", "")

    def initiate_job(
        self,
        vault_name: str = INT_VAULT_NAME,
        job_type: str = "inventory-retrieval",
        archive_id: str | None = None,
    ) -> str:
        body: dict = {"Type": job_type}
        if archive_id is not None:
            body["ArchiveId"] = archive_id
        r = self._client.post(f"/-/vaults/{vault_name}/jobs", json=body)
        return r.headers.get("x-amz-job-id", "")
