"""Shared fixtures for elasticache E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a cache cluster "{cluster_id}" was created'),
    target_fixture="given_cluster",
)
def a_cache_cluster_was_created(cluster_id, lws_invoke, e2e_port):
    lws_invoke(
        [
            "elasticache",
            "create-cache-cluster",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"cluster_id": cluster_id}
    runner.invoke(
        app,
        [
            "elasticache",
            "delete-cache-cluster",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@then(parsers.parse('cache cluster "{cluster_id}" will appear in the list'))
def cache_cluster_will_appear_in_list(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "elasticache",
            "describe-cache-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["CacheClusterId"] for c in verify["CacheClusters"]]
    assert cluster_id in actual_ids


@then(parsers.parse('cache cluster "{cluster_id}" will have status "{expected_status}"'))
def cache_cluster_will_have_status(cluster_id, expected_status, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "elasticache",
            "describe-cache-clusters",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ]
    )
    actual_status = verify["CacheClusters"][0]["CacheClusterStatus"]
    assert actual_status == expected_status


@then(parsers.parse('cache cluster "{cluster_id}" will not appear in the list'))
def cache_cluster_will_not_appear_in_list(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "elasticache",
            "describe-cache-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["CacheClusterId"] for c in verify["CacheClusters"]]
    assert cluster_id not in actual_ids


@when(
    parsers.parse('I create a cache cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_create_a_cache_cluster(cluster_id, e2e_port):
    result = runner.invoke(
        app,
        [
            "elasticache",
            "create-cache-cluster",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )
    yield result
    runner.invoke(
        app,
        [
            "elasticache",
            "delete-cache-cluster",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete cache cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_delete_cache_cluster(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "elasticache",
            "delete-cache-cluster",
            "--cache-cluster-id",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when("I describe cache clusters", target_fixture="command_result")
def i_describe_cache_clusters(e2e_port):
    return runner.invoke(
        app,
        [
            "elasticache",
            "describe-cache-clusters",
            "--port",
            str(e2e_port),
        ],
    )
