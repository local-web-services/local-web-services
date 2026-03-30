"""Given: the parameter exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("the parameter exists")
def param_exists(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
