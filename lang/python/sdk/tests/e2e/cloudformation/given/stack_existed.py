"""Given: the "cloudformation" "stack" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudformationTestClient


@given('the "cloudformation" "stack" existed')
def stack_existed(lws_session):
    CloudformationTestClient(lws_session).create_stack()
