"""When: tags are removed from a "memorydb" "resource" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import MemorydbTestClient
from ..constants import _MDB_TARGET, INT_TAG_KEY


@when('tags are removed from a "memorydb" "resource"')
def remove_tags_from_memorydb_resource(client: TestClient, world):
    arn = MemorydbTestClient(client).get_cluster_arn()
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.UntagResource"},
        json={"ResourceArn": arn, "TagKeys": [INT_TAG_KEY]},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
