"""Given: the parameter "EXISTS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('the parameter "EXISTS"')
def param_exists_given(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
