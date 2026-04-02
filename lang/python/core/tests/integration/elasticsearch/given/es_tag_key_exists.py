"""Given: the "elasticsearch" "tag key" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient
from ..constants import INT_TAG_KEY, INT_TAG_VALUE


@given('the "elasticsearch" "tag key" existed')
def es_tag_key_exists(client: TestClient):
    arn = ElasticsearchTestClient(client).get_domain_arn()
    ElasticsearchTestClient(client).post(
        "AddTags",
        {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]},
    )
