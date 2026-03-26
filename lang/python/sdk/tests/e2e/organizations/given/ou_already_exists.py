"""Given: the organizational unit already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient
from ..constants import TEST_OU_NAME


@given("the organizational unit already exists")
def ou_already_exists(lws_session, world):
    world["ou_id"] = OrganizationsTestClient(lws_session).create_ou(world["root_id"], TEST_OU_NAME)
    world["existing_ou_name"] = TEST_OU_NAME
