"""Given: a parameter has been written without overwrite when it already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("a parameter has been written without overwrite when it already exists")
def ssm_a_parameter_has_been_written_without_overwrite(lws_session):
    SsmTestClient(lws_session).create_param()
