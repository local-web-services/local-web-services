"""Shared fixtures for neptune E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a Neptune DB cluster "{cluster_id}" was created'),
    target_fixture="given_cluster",
)
def a_neptune_db_cluster_was_created(cluster_id, lws_invoke, e2e_port):
    lws_invoke(
        [
            "neptune",
            "create-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"cluster_id": cluster_id}
    runner.invoke(
        app,
        [
            "neptune",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@then(parsers.parse('cluster "{cluster_id}" will appear in describe-db-clusters'))
def cluster_will_appear_in_describe(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "neptune",
            "describe-db-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
    assert cluster_id in actual_ids


@then(parsers.parse('cluster "{cluster_id}" will not appear in describe-db-clusters'))
def cluster_will_not_appear_in_describe(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "neptune",
            "describe-db-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
    assert cluster_id not in actual_ids


@when(
    parsers.parse('I create a Neptune DB cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_create_a_neptune_db_cluster(cluster_id, e2e_port):
    result = runner.invoke(
        app,
        [
            "neptune",
            "create-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )
    yield result
    runner.invoke(
        app,
        [
            "neptune",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete Neptune DB cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_delete_neptune_db_cluster(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "neptune",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe Neptune DB clusters with identifier "{cluster_id}"'),
    target_fixture="command_result",
)
def i_describe_neptune_db_clusters_by_id(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "neptune",
            "describe-db-clusters",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@then(parsers.parse('the output DB cluster identifier will be "{expected_id}"'))
def the_output_db_cluster_identifier_will_be(expected_id, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_identifier = body["DBClusters"][0]["DBClusterIdentifier"]
    assert actual_identifier == expected_id


@then("the output will contain a non-empty Endpoint field")
def the_output_will_contain_endpoint(command_result, parse_output):
    body = parse_output(command_result.output)
    actual_endpoint = body["DBCluster"]["Endpoint"]
    assert actual_endpoint, "Endpoint should be non-empty"


@then("the output will contain exactly 1 DB cluster")
def the_output_will_contain_one_db_cluster(command_result, parse_output):
    body = parse_output(command_result.output)
    assert len(body["DBClusters"]) == 1
