"""When: tags are added to a domain"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_DOMAIN, INT_TAG_KEY, INT_TAG_VALUE, _store


@when("tags are added to a domain")
def add_tags_to_domain(client: TestClient, world: dict):
    arn = OpensearchTestClient(client).get_domain_arn()
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = OpensearchTestClient(client).post(
        "AddTags", {"ARN": arn, "TagList": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}]}
    )
    _store(world, r)
