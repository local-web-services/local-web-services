"""Given: the instance is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given('the instance is not "AVAILABLE"')
def instance_is_not_available_given(lws_session):
    RdsTestClient(lws_session).create_db_instance()
