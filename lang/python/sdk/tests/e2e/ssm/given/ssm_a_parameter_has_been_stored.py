"""Given: a parameter has been stored in "SSM" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('a parameter has been stored in "SSM"')
def ssm_a_parameter_has_been_stored(lws_session):
    SsmTestClient(lws_session).create_param()
