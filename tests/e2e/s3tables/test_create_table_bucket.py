"""E2E test for s3tables create-table-bucket command."""

from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateTableBucket:
    def test_create_table_bucket(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-create-tb"

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
        data = assert_invoke(["s3tables", "list-table-buckets", "--port", str(e2e_port)])
        actual_names = [b["name"] for b in data.get("tableBuckets", [])]
        assert bucket_name in actual_names
