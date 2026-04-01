"""Given: the "neptune" "cluster" was not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the "neptune" "cluster" was not "AVAILABLE"')
def cluster_is_not_available_given(lws_session, world):
    LambdaNeptuneTestClient(lws_session).create_cluster()
