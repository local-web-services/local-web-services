"""Given: the "ssm" "parameter" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmEventsTestClient


@given('the "ssm" "parameter" already existed')
def param_already_exists(lws_session):
    SsmEventsTestClient(lws_session).create_param()
