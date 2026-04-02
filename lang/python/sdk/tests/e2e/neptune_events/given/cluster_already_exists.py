"""Given: the "neptune" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneEventsTestClient


@given('the "neptune" "cluster" already existed')
def cluster_already_exists(lws_session):
    NeptuneEventsTestClient(lws_session).create_cluster()
