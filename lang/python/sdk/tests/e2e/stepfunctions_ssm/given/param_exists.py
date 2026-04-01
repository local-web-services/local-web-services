"""Given: the parameter will exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("the parameter will exist")
def param_exists(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
