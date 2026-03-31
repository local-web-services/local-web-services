"""Given: the "neptune" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" already existed')
def cluster_already_exists(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
