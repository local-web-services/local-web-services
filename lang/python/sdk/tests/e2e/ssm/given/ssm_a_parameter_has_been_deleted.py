"""Given: a parameter has been deleted from "SSM" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@given('a parameter has been deleted from "SSM"')
def ssm_a_parameter_has_been_deleted(lws_session):
    SsmTestClient(lws_session).create_param()
    try:
        SsmTestClient(lws_session).delete_parameter(Name=TEST_PARAM)
    except Exception:
        pass
