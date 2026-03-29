"""Test client for rds_lambda tests."""

from __future__ import annotations

import pytest

from .constants import ROLE_ARN, TEST_CLUSTER, TEST_FUNC


class RdsLambdaTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _rds = lws_session.client("rds")
        self._rds = _rds
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda

    def create_db_instance(self, name=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._rds.create_db_instance(
            DBInstanceIdentifier=name,
            DBInstanceClass="db.t3.micro",
            Engine="mysql",
            MasterUsername="admin",
            MasterUserPassword="password123",
            AllocatedStorage=20,
        )

    def get_db_instance_exists(self, name=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        try:
            self._rds.describe_db_instances(DBInstanceIdentifier=name)
            return True
        except Exception:
            return False

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def get_function_exists(self, name=TEST_FUNC):
        try:
            self._lambda.get_function(FunctionName=name)
            return True
        except Exception:
            return False
