"""Given: the new primary instance exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("the new primary instance exists")
def new_primary_instance_exists(lws_session):
    NeptuneTestClient(lws_session).create_instance(instance_id="e2e-test-instance-2")
