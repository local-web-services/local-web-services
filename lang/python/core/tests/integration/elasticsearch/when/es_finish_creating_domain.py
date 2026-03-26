"""When: a search domain finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient
from ..constants import INT_DOMAIN, _store


@when("a search domain finishes creating")
def es_finish_creating_domain(client: TestClient, world: dict):
    r = ElasticsearchTestClient(client).post(
        "DescribeElasticsearchDomain", {"DomainName": INT_DOMAIN}
    )
    _store(world, r)
