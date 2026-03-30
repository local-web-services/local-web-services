"""Given: did in db_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given("did in db_status")
def did_in_db_status(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
