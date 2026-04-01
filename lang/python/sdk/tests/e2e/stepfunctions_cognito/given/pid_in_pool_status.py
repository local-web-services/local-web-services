"""Given: pid in pool_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given("pid in pool_status")
def pid_in_pool_status(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
