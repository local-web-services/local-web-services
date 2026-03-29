"""Given: the instance already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given("the instance already exists")
def instance_already_exists(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
