"""Given: the instance exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given("the instance exists")
def instance_exists(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
