"""Given: pgid in pg_exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("pgid in pg_exists")
def pgid_in_pg_exists(lws_session):
    ElasticacheTestClient(lws_session).create_parameter_group()
