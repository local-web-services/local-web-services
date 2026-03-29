"""Given: the pool exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given("the pool exists")
def pool_exists(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
