"""Given: a parameter has been created in "SSM" Parameter Store"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('a parameter has been created in "SSM" Parameter Store')
def ssm_parameter_has_been_created(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
