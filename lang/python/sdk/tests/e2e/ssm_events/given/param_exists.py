"""Given: the "ssm" "parameter" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmEventsTestClient


@given('the "ssm" "parameter" existed')
def param_exists(lws_session):
    SsmEventsTestClient(lws_session).create_param()
