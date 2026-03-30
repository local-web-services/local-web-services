"""Given: the "DB" instance exists and is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('the "DB" instance exists and is "AVAILABLE"')
def rds_lambda_db_exists_and_available(lws_session):
    RdsLambdaTestClient(lws_session).create_db_instance()
