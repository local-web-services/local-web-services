"""Given: the "rds" "instance" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the "rds" "instance" already existed')
def instance_already_exists(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
