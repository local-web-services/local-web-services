"""Given: the new primary "documentdb" "instance" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the new primary "documentdb" "instance" existed')
def new_primary_instance_exists(lws_session):
    DocdbTestClient(lws_session).create_instance(instance_id="e2e-test-instance-2")
