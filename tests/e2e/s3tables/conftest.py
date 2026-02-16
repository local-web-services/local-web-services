"""Shared fixtures for s3tables E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a namespace "{namespace_name}" was created in table bucket "{bucket_name}"'),
    target_fixture="given_namespace",
)
def a_namespace_was_created(namespace_name, bucket_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "s3tables",
            "create-namespace",
            "--table-bucket",
            bucket_name,
            "--namespace",
            namespace_name,
            "--port",
            str(e2e_port),
        ]
    )
    return {"bucket_name": bucket_name, "namespace_name": namespace_name}


@given(
    parsers.parse('a table bucket "{bucket_name}" was created'),
    target_fixture="given_table_bucket",
)
def a_table_bucket_was_created(bucket_name, lws_invoke, e2e_port):
    lws_invoke(
        [
            "s3tables",
            "create-table-bucket",
            "--name",
            bucket_name,
            "--port",
            str(e2e_port),
        ]
    )
    return {"bucket_name": bucket_name}


@when(
    parsers.parse(
        'I create table "{table_name}" in namespace "{namespace_name}"'
        ' of table bucket "{bucket_name}"'
    ),
    target_fixture="command_result",
)
def i_create_table(table_name, namespace_name, bucket_name, e2e_port):
    return runner.invoke(
        app,
        [
            "s3tables",
            "create-table",
            "--table-bucket",
            bucket_name,
            "--namespace",
            namespace_name,
            "--name",
            table_name,
            "--port",
            str(e2e_port),
        ],
    )


@when(
    parsers.parse('I create table bucket "{bucket_name}"'),
    target_fixture="command_result",
)
def i_create_table_bucket(bucket_name, e2e_port):
    return runner.invoke(
        app,
        [
            "s3tables",
            "create-table-bucket",
            "--name",
            bucket_name,
            "--port",
            str(e2e_port),
        ],
    )


@then(
    parsers.parse('the table bucket list will include "{bucket_name}"'),
)
def the_table_bucket_list_will_include(bucket_name, assert_invoke, e2e_port):
    data = assert_invoke(["s3tables", "list-table-buckets", "--port", str(e2e_port)])
    actual_names = [b["name"] for b in data.get("tableBuckets", [])]
    assert bucket_name in actual_names


@then(
    parsers.parse(
        'the table list in namespace "{namespace_name}"'
        ' of table bucket "{bucket_name}" will include "{table_name}"'
    ),
)
def the_table_list_will_include(table_name, namespace_name, bucket_name, assert_invoke, e2e_port):
    data = assert_invoke(
        [
            "s3tables",
            "list-tables",
            "--table-bucket",
            bucket_name,
            "--namespace",
            namespace_name,
            "--port",
            str(e2e_port),
        ]
    )
    actual_names = [t["name"] for t in data.get("tables", [])]
    assert table_name in actual_names
