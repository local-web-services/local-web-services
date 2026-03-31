"""Given: the "neptune" "cluster" did not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" did not exist')
def cluster_does_not_exist(lws_session):
    """Delete the cluster if it exists so any instance cluster reference is orphaned."""
    NeptuneTestClient(lws_session).delete_cluster()
