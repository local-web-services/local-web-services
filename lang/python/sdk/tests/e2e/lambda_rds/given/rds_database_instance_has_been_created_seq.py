"""Given: an "RDS" database instance has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('an "RDS" database instance has been created')
def rds_database_instance_has_been_created_seq(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
