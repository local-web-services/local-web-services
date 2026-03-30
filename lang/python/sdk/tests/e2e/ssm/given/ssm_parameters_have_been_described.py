"""Given: parameters have been described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("parameters have been described")
def ssm_parameters_have_been_described(lws_session):
    SsmTestClient(lws_session).create_param()
