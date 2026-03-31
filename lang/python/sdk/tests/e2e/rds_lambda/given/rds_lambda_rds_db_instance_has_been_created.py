"""Given: a "RDS" "DB" instance is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('a "RDS" "DB" instance is created')
def rds_lambda_rds_db_instance_has_been_created(lws_session):
    RdsLambdaTestClient(lws_session).create_db_instance()
