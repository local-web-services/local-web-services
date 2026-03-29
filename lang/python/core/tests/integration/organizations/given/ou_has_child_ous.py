"""Given: the organizational unit has child organizational units"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given("the organizational unit has child organizational units")
def ou_has_child_ous(client: TestClient, world):
    OrganizationsTestClient(client).create_ou(world["ou_id"], "int-test-child-ou-1")
