"""Given: the "neptune" "instance" belongs to this "neptune" "cluster" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "instance" belongs to this "neptune" "cluster"')
def instance_belongs_to_cluster(lws_session):
    NeptuneTestClient(lws_session).create_instance()
