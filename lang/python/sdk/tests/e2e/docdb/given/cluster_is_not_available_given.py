"""Given: the cluster is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given(lws_session):
    DocdbTestClient(lws_session).create_cluster()
