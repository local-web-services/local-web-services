from __future__ import annotations

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateDBCluster:
    def test_create_db_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-docdb-create"

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
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

    def test_create_and_describe_by_id(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-docdb-desc-id"
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

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert len(body["DBClusters"]) == 1
        actual_identifier = body["DBClusters"][0]["DBClusterIdentifier"]
        assert actual_identifier == cluster_id

    def test_create_and_delete(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-docdb-delete"
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

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
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
