"""E2E test for s3tables full lifecycle: create bucket, namespace, table, list tables."""

from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateTable:
    def test_full_lifecycle(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-tbl-lifecycle-tb"
        namespace_name = "e2e-tbl-ns"
        table_name = "e2e-events"

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

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
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
