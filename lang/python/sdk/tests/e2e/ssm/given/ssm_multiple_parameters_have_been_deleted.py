"""Given: multiple parameters have been deleted from "SSM" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@given('multiple parameters have been deleted from "SSM"')
def ssm_multiple_parameters_have_been_deleted(lws_session):
    SsmTestClient(lws_session).create_param()
    try:
        SsmTestClient(lws_session).delete_parameters(Names=[TEST_PARAM])
    except Exception:
        pass
