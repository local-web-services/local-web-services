"""Given: the "neptune" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" existed')
def cluster_exists(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
