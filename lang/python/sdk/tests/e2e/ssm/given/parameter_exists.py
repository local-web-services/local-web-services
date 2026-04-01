"""Given: the "ssm" "parameter" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('the "ssm" "parameter" existed')
def parameter_exists(lws_session):
    SsmTestClient(lws_session).create_param()
