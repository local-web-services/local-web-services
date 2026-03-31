"""Given: the "DB" instance existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsRdsTestClient


@given('the "DB" instance existed')
def db_instance_exists(lws_session):
    StepfunctionsRdsTestClient(lws_session).create_cluster()
