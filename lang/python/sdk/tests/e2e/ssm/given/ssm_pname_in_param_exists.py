"""Given: pname in param_exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("pname in param_exists")
def ssm_pname_in_param_exists(lws_session):
    SsmTestClient(lws_session).create_param()
