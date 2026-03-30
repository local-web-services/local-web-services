"""Given: a Neptune cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given("a Neptune cluster has been created")
def neptune_cluster_has_been_created_seq(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
