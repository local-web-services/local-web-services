"""Given: the "ssm" "parameter" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given('the "ssm" "parameter" existed')
def ssm_parameter_has_been_created(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
