"""Given: "ssm" "parameter"s are described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('"ssm" "parameter"s are described')
def ssm_parameters_have_been_described(lws_session):
    SsmTestClient(lws_session).create_param()
