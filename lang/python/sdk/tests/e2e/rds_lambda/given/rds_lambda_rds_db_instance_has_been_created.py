"""Given: an "RDS" "DB" instance has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('an "RDS" "DB" instance has been created')
def rds_lambda_rds_db_instance_has_been_created(lws_session):
    RdsLambdaTestClient(lws_session).create_db_instance()
