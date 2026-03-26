"""Given: the parameter already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("the parameter already exists")
def parameter_already_exists(lws_session):
    SsmTestClient(lws_session).create_param()
