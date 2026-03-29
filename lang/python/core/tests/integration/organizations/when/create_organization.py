"""When: an organization is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_ORG_FEATURE_SET


@when("an organization is created")
def create_organization(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "CreateOrganization", {"FeatureSet": INT_ORG_FEATURE_SET}
    )
    if status == 200:
        world["result"] = body
        world["org_id"] = body.get("Organization", {}).get("Id")
    else:
        world["error"] = body
