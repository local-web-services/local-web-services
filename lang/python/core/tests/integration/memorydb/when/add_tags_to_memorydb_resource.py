"""When: tags are added to a "memorydb" "resource" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import MemorydbTestClient
from ..constants import _MDB_TARGET, INT_TAG_KEY, INT_TAG_VALUE


@when('tags are added to a "memorydb" "resource"')
def add_tags_to_memorydb_resource(client: TestClient, world):
    arn = MemorydbTestClient(client).get_cluster_arn()
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.TagResource"},
        json={
            "ResourceArn": arn,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
