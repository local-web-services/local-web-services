"""When: tags are removed from a domain"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient
from ..constants import INT_DOMAIN, INT_TAG_KEY, _store


@when("tags are removed from a domain")
def es_remove_tags_from_domain(client: TestClient, world: dict):
    arn = ElasticsearchTestClient(client).get_domain_arn()
    if not arn:
        world["result"] = None
        world["error"] = {"message": f"Domain {INT_DOMAIN} not found"}
        return
    r = ElasticsearchTestClient(client).post("RemoveTags", {"ARN": arn, "TagKeys": [INT_TAG_KEY]})
    _store(world, r)
