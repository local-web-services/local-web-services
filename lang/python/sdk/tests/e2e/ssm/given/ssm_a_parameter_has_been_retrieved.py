"""Given: a parameter has been retrieved from "SSM" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM


@given('a parameter has been retrieved from "SSM"')
def ssm_a_parameter_has_been_retrieved(lws_session):
    SsmTestClient(lws_session).create_param()
    SsmTestClient(lws_session).get_parameter(Name=TEST_PARAM)
