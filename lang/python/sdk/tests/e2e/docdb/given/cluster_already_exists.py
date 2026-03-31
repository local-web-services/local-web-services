"""Given: the "documentdb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the "documentdb" "cluster" already existed')
def cluster_already_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
