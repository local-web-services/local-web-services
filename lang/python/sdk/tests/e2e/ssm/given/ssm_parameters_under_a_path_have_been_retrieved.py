"""Given: parameters under a path have been retrieved from "SSM" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given('parameters under a path have been retrieved from "SSM"')
def ssm_parameters_under_a_path_have_been_retrieved(lws_session):
    SsmTestClient(lws_session).create_param()
