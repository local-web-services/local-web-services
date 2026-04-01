"""Given: a "rds" "database instance" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('a "rds" "database instance" is created')
def rds_database_instance_has_been_created_seq(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
