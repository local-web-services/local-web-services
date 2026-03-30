"""Given: a parameter has been deleted from "SSM" Parameter Store"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient
from ..constants import TEST_PARAM


@given('a parameter has been deleted from "SSM" Parameter Store')
def ssm_parameter_has_been_deleted(lws_session, world):
    client = StepfunctionsSsmTestClient(lws_session)
    try:
        client.create_param()
    except Exception:
        pass
    try:
        lws_session.client("ssm").delete_parameter(Name=TEST_PARAM)
    except Exception:
        pass
