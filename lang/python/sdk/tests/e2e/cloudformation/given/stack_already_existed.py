"""Given: the "cloudformation" "stack" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudformationTestClient


@given('the "cloudformation" "stack" already existed')
def stack_already_existed(lws_session):
    CloudformationTestClient(lws_session).create_stack()
