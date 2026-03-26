"""Given: iid in instance_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given("iid in instance_status")
def iid_in_instance_status(lws_session):
    RdsTestClient(lws_session).create_db_instance()
