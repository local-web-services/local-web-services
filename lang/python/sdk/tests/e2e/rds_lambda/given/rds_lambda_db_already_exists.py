"""Given: the "DB" instance already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given('the "DB" instance already existed')
def rds_lambda_db_already_exists(lws_session):
    RdsLambdaTestClient(lws_session).create_db_instance()
