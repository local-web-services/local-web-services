"""Test client for lambda_elasticache tests."""

from __future__ import annotations

import pytest

from .constants import ROLE_ARN, TEST_CLUSTER, TEST_FUNC


class LambdaElasticacheTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _elasticache = lws_session.client("elasticache")
        self._elasticache = _elasticache

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
        self._elasticache.create_cache_cluster(
            CacheClusterId=name,
            CacheNodeType="cache.t3.micro",
            Engine="redis",
            NumCacheNodes=1,
        )
