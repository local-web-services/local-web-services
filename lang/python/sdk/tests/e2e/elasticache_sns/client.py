"""Test client for elasticache_sns tests."""

from __future__ import annotations

import pytest

from .constants import TEST_CLUSTER, TEST_TOPIC


class ElasticacheSnsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _elasticache = lws_session.client("elasticache")
        self._elasticache = _elasticache
        _sns = lws_session.client("sns")
        self._sns = _sns

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._elasticache.create_cache_cluster(
            CacheClusterId=cluster_id,
            CacheNodeType="cache.t3.micro",
            Engine="redis",
            NumCacheNodes=1,
        )

    def create_topic(self, name=TEST_TOPIC):
        resp = self._sns.create_topic(Name=name)
        return resp["TopicArn"]
