"""Given: a "neptune" "cluster" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('a "neptune" "cluster" is created')
def neptune_cluster_has_been_created_seq(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
