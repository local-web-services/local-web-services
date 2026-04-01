"""Given: the "neptune" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the "neptune" "cluster" existed')
def cluster_exists(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
