"""Given: the parameter already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("the parameter already exists")
def param_already_exists(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
