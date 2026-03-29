"""Given: a parameter has been deleted from "SSM" Parameter Store"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient
from ..constants import TEST_PARAM


@given('a parameter has been deleted from "SSM" Parameter Store')
def ssm_parameter_has_been_deleted_seq(lws_session):
    try:
        LambdaSsmTestClient(lws_session).create_param()
    except Exception:
        pass
    LambdaSsmTestClient(lws_session)._ssm.delete_parameter(Name=TEST_PARAM)
