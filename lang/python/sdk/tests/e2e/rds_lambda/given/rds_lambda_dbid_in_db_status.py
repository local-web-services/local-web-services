"""Given: dbid in db_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsLambdaTestClient


@given("dbid in db_status")
def rds_lambda_dbid_in_db_status(lws_session):
    RdsLambdaTestClient(lws_session).create_db_instance()
