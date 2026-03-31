"""Given: the "elasticache" "resource" has tags"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient
from ..constants import _EC_TARGET, INT_TAG_KEY, INT_TAG_VALUE


@given('the "elasticache" "resource" has tags')
def resource_has_tags(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
    arn = ElasticacheTestClient(client).get_cluster_arn()
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EC_TARGET}.AddTagsToResource"},
        json={"ResourceName": arn, "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
