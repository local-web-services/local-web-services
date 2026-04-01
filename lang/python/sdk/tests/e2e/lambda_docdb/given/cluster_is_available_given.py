"""Given: the "documentdb" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaDocdbTestClient


@given('the "documentdb" "cluster" was "AVAILABLE"')
def cluster_is_available_given(lws_session):
    LambdaDocdbTestClient(lws_session).create_cluster()
