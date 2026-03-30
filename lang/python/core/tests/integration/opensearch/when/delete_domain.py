"""When: a search domain is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_DOMAIN, _store


@when("a search domain is deleted")
def delete_domain(client: TestClient, world: dict):
    r = OpensearchTestClient(client).post("DeleteDomain", {"DomainName": INT_DOMAIN})
    _store(world, r)
