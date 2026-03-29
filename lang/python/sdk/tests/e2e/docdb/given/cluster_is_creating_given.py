"""Given: the cluster is "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the cluster is "CREATING"')
def cluster_is_creating_given(lws_session):
    DocdbTestClient(lws_session).create_cluster()
