"""Given: a "neptune" "cluster" is created and becomes "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given('a "neptune" "cluster" is created and becomes "AVAILABLE"')
def neptune_cluster_created_and_available_seq(lws_session):
    NeptuneEventsTestClient(lws_session).create_cluster()
