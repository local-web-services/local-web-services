"""Test client for lambda_memorydb tests."""

from __future__ import annotations

import pytest

from .constants import ROLE_ARN, TEST_CLUSTER, TEST_FUNC


class LambdaMemorydbTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _memorydb = lws_session.client("memorydb")
        self._memorydb = _memorydb

    def create_function(self, name=TEST_FUNC):
        self._lambda.create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )

    def create_cluster(self, name=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._memorydb.create_cluster(
            ClusterName=name, NodeType="db.t4g.small", ACLName="open-access"
        )
