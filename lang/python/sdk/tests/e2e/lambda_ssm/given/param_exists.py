"""Given: the parameter exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient


@given("the parameter exists")
def param_exists(lws_session):
    LambdaSsmTestClient(lws_session).create_param()
