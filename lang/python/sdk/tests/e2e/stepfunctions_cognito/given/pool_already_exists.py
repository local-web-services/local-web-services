"""Given: the pool already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsCognitoTestClient


@given("the pool already exists")
def pool_already_exists(lws_session):
    StepfunctionsCognitoTestClient(lws_session).create_pool()
