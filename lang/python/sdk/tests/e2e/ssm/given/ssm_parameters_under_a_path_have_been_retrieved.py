"""Given: "ssm" "parameter"s under a path are retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('"ssm" "parameter"s under a path are retrieved')
def ssm_parameters_under_a_path_have_been_retrieved(lws_session):
    SsmTestClient(lws_session).create_param()
