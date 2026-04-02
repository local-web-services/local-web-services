"""Given: multiple "organizations" "organizational units" existed under the root"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient
from ..constants import TEST_OU_NAMES


@given('multiple "organizations" "organizational units" existed under the root')
def multiple_ous_existed_under_root(lws_session, world):
    helper = OrganizationsTestClient(lws_session)
    root_id = world["root_id"]
    ou_ids = [helper.create_ou(root_id, name) for name in TEST_OU_NAMES]
    world["ou_ids"] = ou_ids
