"""Shared fixtures for rds E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a DB cluster "{cluster_id}" was created'),
    target_fixture="given_db_cluster",
)
def a_db_cluster_was_created(cluster_id, lws_invoke, e2e_port):
    lws_invoke(
        [
            "rds",
            "create-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"db_cluster_identifier": cluster_id}
    runner.invoke(
        app,
        [
            "rds",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@given(
    parsers.parse('a DB instance "{db_id}" was created'),
    target_fixture="given_db_instance",
)
def a_db_instance_was_created(db_id, lws_invoke, e2e_port):
    lws_invoke(
        [
            "rds",
            "create-db-instance",
            "--db-instance-identifier",
            db_id,
            "--port",
            str(e2e_port),
        ]
    )
    yield {"db_instance_identifier": db_id}
    runner.invoke(
        app,
        ["rds", "delete-db-instance", "--db-instance-identifier", db_id, "--port", str(e2e_port)],
    )


@then(
    parsers.parse('DB cluster "{cluster_id}" will appear in the output'),
)
def db_cluster_will_appear_in_output(cluster_id, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_ids = [c["DBClusterIdentifier"] for c in body["DBClusters"]]
    assert cluster_id in actual_ids


@then(
    parsers.parse('DB cluster "{cluster_id}" will exist'),
)
def db_cluster_will_exist(cluster_id, assert_invoke, e2e_port):
    verify = assert_invoke(["rds", "describe-db-clusters", "--port", str(e2e_port)])
    actual_ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
    assert cluster_id in actual_ids


@then(
    parsers.parse('DB instance "{db_id}" will appear in the output'),
)
def db_instance_will_appear_in_output(db_id, command_result, parse_output):
    body = parse_output(command_result.output)
    actual_ids = [i["DBInstanceIdentifier"] for i in body["DBInstances"]]
    assert db_id in actual_ids


@then(
    parsers.parse('DB instance "{db_id}" will exist'),
)
def db_instance_will_exist(db_id, assert_invoke, e2e_port):
    verify = assert_invoke(["rds", "describe-db-instances", "--port", str(e2e_port)])
    actual_ids = [i["DBInstanceIdentifier"] for i in verify["DBInstances"]]
    assert db_id in actual_ids


@then(
    parsers.parse('DB instance "{db_id}" will not exist'),
)
def db_instance_will_not_exist(db_id, assert_invoke, e2e_port):
    verify = assert_invoke(["rds", "describe-db-instances", "--port", str(e2e_port)])
    actual_ids = [i["DBInstanceIdentifier"] for i in verify["DBInstances"]]
    assert db_id not in actual_ids


@when(
    parsers.parse('I create a DB cluster "{cluster_id}"'),
    target_fixture="command_result",
)
def i_create_a_db_cluster(cluster_id, e2e_port):
    result = runner.invoke(
        app,
        [
            "rds",
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
            "rds",
            "delete-db-cluster",
            "--db-cluster-identifier",
            cluster_id,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create a DB instance "{db_id}"'),
    target_fixture="command_result",
)
def i_create_a_db_instance(db_id, e2e_port):
    result = runner.invoke(
        app,
        [
            "rds",
            "create-db-instance",
            "--db-instance-identifier",
            db_id,
            "--port",
            str(e2e_port),
        ],
    )
    yield result
    runner.invoke(
        app,
        ["rds", "delete-db-instance", "--db-instance-identifier", db_id, "--port", str(e2e_port)],
    )


@when(
    parsers.parse('I delete DB instance "{db_id}"'),
    target_fixture="command_result",
)
def i_delete_db_instance(db_id, e2e_port):
    return runner.invoke(
        app,
        [
            "rds",
            "delete-db-instance",
            "--db-instance-identifier",
            db_id,
            "--port",
            str(e2e_port),
        ],
    )


@when("I describe DB clusters", target_fixture="command_result")
def i_describe_db_clusters(e2e_port):
    return runner.invoke(
        app,
        [
            "rds",
            "describe-db-clusters",
            "--port",
            str(e2e_port),
        ],
    )


@when("I describe DB instances", target_fixture="command_result")
def i_describe_db_instances(e2e_port):
    return runner.invoke(
        app,
        [
            "rds",
            "describe-db-instances",
            "--port",
            str(e2e_port),
        ],
    )
