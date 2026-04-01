"""When: an "elasticsearch" "domain" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient
from ..constants import INT_DOMAIN, _store


@when('an "elasticsearch" "domain" is created')
def es_create_domain(client: TestClient, world: dict):
    r = ElasticsearchTestClient(client).post(
        "CreateElasticsearchDomain", {"DomainName": INT_DOMAIN}
    )
    _store(world, r)
