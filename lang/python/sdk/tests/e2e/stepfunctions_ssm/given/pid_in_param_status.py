"""Given: pid in param_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient


@given("pid in param_status")
def pid_in_param_status(lws_session):
    StepfunctionsSsmTestClient(lws_session).create_param()
