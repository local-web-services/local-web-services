"""Test client for neptune tests."""

from __future__ import annotations

from .constants import _NEPTUNE_TARGET, INT_CLUSTER, INT_INSTANCE


class NeptuneTestClient:
    def __init__(self, client):
        self._client = client

    def post(self, action: str, body: dict):
        return self._client.post(
            "/", headers={"X-Amz-Target": f"{_NEPTUNE_TARGET}.{action}"}, json=body
        )

    def create_cluster(self, cluster_id: str = INT_CLUSTER) -> None:
        self.post("CreateDBCluster", {"DBClusterIdentifier": cluster_id, "Engine": "neptune"})

    def create_instance(
        self, instance_id: str = INT_INSTANCE, cluster_id: str = INT_CLUSTER
    ) -> None:
        self.post(
            "CreateDBInstance",
            {
                "DBInstanceIdentifier": instance_id,
                "DBClusterIdentifier": cluster_id,
                "DBInstanceClass": "db.r5.large",
                "Engine": "neptune",
            },
        )
