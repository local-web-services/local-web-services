"""Given: the "documentdb" "cluster" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the "documentdb" "cluster" was "CREATING"')
def cluster_is_creating_given(lws_session):
    lws_session.lifecycle("docdb").create_dwell_ms(5000).apply()
    DocdbTestClient(lws_session).create_cluster()
