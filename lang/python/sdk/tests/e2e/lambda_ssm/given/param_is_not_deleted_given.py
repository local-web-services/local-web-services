"""Given: the parameter is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient


@given('the parameter is not "DELETED"')
def param_is_not_deleted_given(lws_session, world):
    LambdaSsmTestClient(lws_session).create_param()
    world["param_deleted"] = False
