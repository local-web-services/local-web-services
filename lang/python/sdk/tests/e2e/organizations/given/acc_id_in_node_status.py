"""Given: acc_id in node_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("acc_id in node_status")
def acc_id_in_node_status(lws_session, world):
    resp = OrganizationsTestClient(lws_session).create_org()
    world["org_id"] = resp["Organization"]["Id"]
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    world["account_id"] = OrganizationsTestClient(lws_session).create_account()
