"""Given: the "memorydb" "resource" was tagged"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient
from ..constants import _MDB_TARGET, INT_TAG_KEY, INT_TAG_VALUE


@given('the "memorydb" "resource" was tagged')
def resource_is_tagged(client: TestClient):
    MemorydbTestClient(client).create_cluster()
    arn = MemorydbTestClient(client).get_cluster_arn()
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.TagResource"},
        json={"ResourceArn": arn, "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
