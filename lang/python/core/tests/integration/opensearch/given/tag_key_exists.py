"""Given: the "elasticsearch" "tag key" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_TAG_KEY, INT_TAG_VALUE


@given('the "opensearch" "tag key" existed')
@given('the "elasticsearch" "tag key" existed')
def tag_key_exists(client: TestClient):
    arn = OpensearchTestClient(client).get_domain_arn()
    OpensearchTestClient(client).post(
        "AddTags", {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]}
    )
