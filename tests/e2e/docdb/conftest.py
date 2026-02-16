"""Shared fixtures for docdb E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a DocDB cluster "{cluster_id}" was created'),
    target_fixture="given_docdb_cluster",
)
def a_docdb_cluster_was_created(cluster_id, lws_invoke, e2e_port):
    lws_invoke(
        [
            "docdb",
            "create-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ]
    )
    return {"db_cluster_identifier": cluster_id}


@then(
    parsers.parse('DocDB cluster "{cluster_id}" will exist'),
)
def docdb_cluster_will_exist(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "docdb",
            "describe-db-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
    assert cluster_id in actual_ids


@then(
    parsers.parse('DocDB cluster "{cluster_id}" will not exist'),
)
def docdb_cluster_will_not_exist(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "docdb",
            "describe-db-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
    assert cluster_id not in actual_ids


@when(
    parsers.parse('I create a DocDB cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_create_a_docdb_cluster(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "docdb",
            "create-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete DocDB cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_delete_docdb_cluster(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "docdb",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I describe DocDB clusters with identifier "{cluster_id}"'),
    target_fixture="command_result",
)
def i_describe_docdb_clusters_by_id(cluster_id, e2e_port):
    return runner.invoke(
        app,
        [
            "docdb",
            "describe-db-clusters",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('the output will contain exactly one cluster "{cluster_id}"'),
)
def output_will_contain_exactly_one_cluster(cluster_id, command_result, parse_output):
    body = parse_output(command_result.output)
    assert len(body["DBClusters"]) == 1
    actual_identifier = body["DBClusters"][0]["DBClusterIdentifier"]
    assert actual_identifier == cluster_id
