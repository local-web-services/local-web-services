"""Given: the "neptune" "cluster" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" was "CREATING"')
def cluster_is_creating_given(lws_session):
    NeptuneTestClient(lws_session).delete_cluster()
    lws_session.lifecycle("neptune").create_dwell_ms(5000).apply()
    NeptuneTestClient(lws_session).create_cluster()
