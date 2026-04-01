"""Given: the "documentdb" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the "documentdb" "cluster" existed')
def cluster_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
