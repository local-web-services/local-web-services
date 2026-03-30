"""Given: the instance is neither "AVAILABLE" nor "FAILED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given('the instance is neither "AVAILABLE" nor "FAILED"')
def instance_is_neither_available_nor_failed_given(lws_session):
    RdsTestClient(lws_session).create_db_instance()
