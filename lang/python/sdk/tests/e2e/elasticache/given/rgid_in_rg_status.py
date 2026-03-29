"""Given: rgid in rg_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("rgid in rg_status")
def rgid_in_rg_status(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
