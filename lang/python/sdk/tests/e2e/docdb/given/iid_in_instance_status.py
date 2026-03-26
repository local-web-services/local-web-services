"""Given: iid in instance_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("iid in instance_status")
def iid_in_instance_status(lws_session):
    DocdbTestClient(lws_session).create_cluster()
    DocdbTestClient(lws_session).create_instance()
