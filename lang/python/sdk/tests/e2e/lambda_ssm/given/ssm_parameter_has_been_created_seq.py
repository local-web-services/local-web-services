"""Given: a parameter has been created in "SSM" Parameter Store"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient


@given('a parameter has been created in "SSM" Parameter Store')
def ssm_parameter_has_been_created_seq(lws_session):
    LambdaSsmTestClient(lws_session).create_param()
