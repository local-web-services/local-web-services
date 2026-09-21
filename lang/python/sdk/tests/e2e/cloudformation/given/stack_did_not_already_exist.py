"""Given: the "cloudformation" "stack" did not already exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudformationTestClient


@given('the "cloudformation" "stack" did not already exist')
def stack_did_not_already_exist(lws_session):
    CloudformationTestClient(lws_session).delete_stack_if_exists()
