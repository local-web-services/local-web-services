"""When: a search domain finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_DOMAIN, _store


@when("a search domain finishes creating")
def finish_creating_domain(client: TestClient, world: dict):
    r = OpensearchTestClient(client).post("DescribeDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)
