"""When: tags are removed from an "elasticache" "resource" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient
from ..constants import _EC_TARGET, INT_TAG_KEY


@when('tags are removed from an "elasticache" "resource"')
def remove_tags_from_cache_resource(client: TestClient, world):
    arn = ElasticacheTestClient(client).get_cluster_arn()
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.RemoveTagsFromResource"},
        json={"ResourceName": arn, "TagKeys": [INT_TAG_KEY]},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
