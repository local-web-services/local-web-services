"""Given: the parameter exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmEventsTestClient


@given("the parameter exists")
def param_exists(lws_session):
    SsmEventsTestClient(lws_session).create_param()
