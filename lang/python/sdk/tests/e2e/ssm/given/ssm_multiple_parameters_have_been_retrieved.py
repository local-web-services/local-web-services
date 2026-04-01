"""Given: multiple "ssm" "parameter"s are retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('multiple "ssm" "parameter"s are retrieved')
def ssm_multiple_parameters_have_been_retrieved(lws_session):
    SsmTestClient(lws_session).create_param()
