"""Given: the "organizations" resource existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_ORG_FEATURE_SET


@given('the "organizations" resource existed')
def resource_exists(client: TestClient, world):
    # Arrange
    expected_feature_set = INT_ORG_FEATURE_SET

    # Act
    _, body = OrganizationsTestClient(client).post(
        "CreateOrganization", {"FeatureSet": expected_feature_set}
    )
    roots = OrganizationsTestClient(client).post("ListRoots", {})[1]
    root_id = roots.get("Roots", [{}])[0].get("Id", "")

    # Assert
    world["resource_id"] = root_id
