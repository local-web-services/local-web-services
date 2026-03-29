"""Given: the parameter is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('the parameter is not "DELETED"')
def param_is_not_deleted_given(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
