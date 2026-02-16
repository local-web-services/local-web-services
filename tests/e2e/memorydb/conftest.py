"""Shared fixtures for memorydb E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a MemoryDB cluster "{cluster_name}" was created'),
    target_fixture="given_cluster",
)
def a_memorydb_cluster_was_created(cluster_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "memorydb",
            "create-cluster",
            "--cluster-name",
            cluster_name,
            "--port",
            str(e2e_port),
        ]
    )
    return {"cluster_name": cluster_name}


@when(
    parsers.parse('I create a MemoryDB cluster "{cluster_name}"'),
    target_fixture="command_result",
)
def i_create_a_memorydb_cluster(cluster_name, e2e_port):
    return runner.invoke(
        app,
        [
            "memorydb",
            "create-cluster",
            "--cluster-name",
            cluster_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I delete MemoryDB cluster "{cluster_name}"'),
    target_fixture="command_result",
)
def i_delete_memorydb_cluster(cluster_name, e2e_port):
    return runner.invoke(
        app,
        [
            "memorydb",
            "delete-cluster",
            "--cluster-name",
            cluster_name,
            "--port",
            str(e2e_port),
        ],
    )


@when("I describe MemoryDB clusters", target_fixture="command_result")
def i_describe_memorydb_clusters(e2e_port):
    return runner.invoke(
        app,
        [
            "memorydb",
            "describe-clusters",
            "--port",
            str(e2e_port),
        ],
    )


@then(parsers.parse('MemoryDB cluster "{cluster_name}" will appear in the list'))
def memorydb_cluster_will_appear_in_list(cluster_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "memorydb",
            "describe-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_names = [c["Name"] for c in verify["Clusters"]]
    assert cluster_name in actual_names


@then(parsers.parse('MemoryDB cluster "{cluster_name}" will have status "{expected_status}"'))
def memorydb_cluster_will_have_status(cluster_name, expected_status, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "memorydb",
            "describe-clusters",
            "--cluster-name",
            cluster_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_status = verify["Clusters"][0]["Status"]
    assert actual_status == expected_status


@then(parsers.parse('MemoryDB cluster "{cluster_name}" will not appear in the list'))
def memorydb_cluster_will_not_appear_in_list(cluster_name, assert_invoke, e2e_port):
    verify = assert_invoke(
        [
            "memorydb",
            "describe-clusters",
            "--port",
            str(e2e_port),
        ]
    )
    actual_names = [c["Name"] for c in verify["Clusters"]]
    assert cluster_name not in actual_names
