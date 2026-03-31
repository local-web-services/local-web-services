"""Given: the "documentdb" "instance" belongs to this documentdb cluster"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the "documentdb" "instance" belongs to this documentdb cluster')
def instance_belongs_to_cluster(lws_session):
    DocdbTestClient(lws_session).create_instance()
