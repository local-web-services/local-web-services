"""When: a search domain finishes deleting"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient
from ..constants import INT_DOMAIN, _store


@when("a search domain finishes deleting")
def es_finish_deleting_domain(client: TestClient, world: dict):
    r = ElasticsearchTestClient(client).post(
        "DeleteElasticsearchDomain", {"DomainName": INT_DOMAIN}
    )
    _store(world, r)
