"""When: tags are removed from an "elasticsearch" "domain" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_DOMAIN, INT_TAG_KEY, _store


@when('tags are removed from an "opensearch" "domain"')
@when('tags are removed from an "elasticsearch" "domain"')
def remove_tags_from_domain(client: TestClient, world: dict):
    arn = OpensearchTestClient(client).get_domain_arn()
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = OpensearchTestClient(client).post("RemoveTags", {"ARN": arn, "TagKeys": [INT_TAG_KEY]})
    _store(world, r)
