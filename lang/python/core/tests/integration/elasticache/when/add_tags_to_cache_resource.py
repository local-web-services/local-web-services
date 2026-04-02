"""When: tags are added to an "elasticache" "resource" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient
from ..constants import _EC_TARGET, INT_TAG_KEY, INT_TAG_VALUE


@when('tags are added to an "elasticache" "resource"')
def add_tags_to_cache_resource(client: TestClient, world):
    arn = ElasticacheTestClient(client).get_cluster_arn()
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.AddTagsToResource"},
        json={
            "ResourceName": arn,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
