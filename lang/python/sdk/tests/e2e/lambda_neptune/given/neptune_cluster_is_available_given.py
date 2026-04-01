"""Given: the "neptune" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the "neptune" "cluster" was "AVAILABLE"')
def neptune_cluster_is_available_given(lws_session):
    LambdaNeptuneTestClient(lws_session).create_cluster()
