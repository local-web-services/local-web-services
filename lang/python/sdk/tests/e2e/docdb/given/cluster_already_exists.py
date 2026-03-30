"""Given: the cluster already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
