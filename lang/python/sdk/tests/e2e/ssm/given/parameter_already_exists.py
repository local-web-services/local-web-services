"""Given: the "ssm" "parameter" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('the "ssm" "parameter" already existed')
def parameter_already_exists(lws_session):
    SsmTestClient(lws_session).create_param()
