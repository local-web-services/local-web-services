"""Test client for rds tests."""

from __future__ import annotations

from .constants import _RDS_TARGET, INT_DB_INSTANCE


class RdsTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, action: str, body: dict):
        return self._client.post(
            "/", headers={"X-Amz-Target": f"{_RDS_TARGET}.{action}"}, json=body
        )

    def create_instance(self, db_id: str = INT_DB_INSTANCE) -> None:
        self.post("CreateDBInstance", {"DBInstanceIdentifier": db_id, "Engine": "postgres"})
