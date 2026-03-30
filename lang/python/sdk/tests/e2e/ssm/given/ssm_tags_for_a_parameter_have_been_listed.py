"""Given: tags for a parameter have been listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient


@given("tags for a parameter have been listed")
def ssm_tags_for_a_parameter_have_been_listed(lws_session):
    SsmTestClient(lws_session).create_param()
