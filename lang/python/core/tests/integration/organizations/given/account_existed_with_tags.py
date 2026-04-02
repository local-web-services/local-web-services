"""Given: the "organizations" "account" existed with tags"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_ACCOUNT_TAGS


@given('the "organizations" "account" existed with tags')
def account_existed_with_tags(client: TestClient, world):
    # Arrange
    helper = OrganizationsTestClient(client)
    account_id = helper.create_account()
    helper.tag_resource(account_id, INT_ACCOUNT_TAGS)
    world["account_id"] = account_id
    world["account_tags"] = INT_ACCOUNT_TAGS
