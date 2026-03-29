"""Given: the parameter exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("the parameter exists")
def parameter_exists(lws_session):
    SsmTestClient(lws_session).create_param()
