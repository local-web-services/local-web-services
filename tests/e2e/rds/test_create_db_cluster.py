from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateDBCluster:
    def test_create_db_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-rds-create-cluster"
        expected_cluster_id = cluster_id

        # Act
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

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["rds", "describe-db-clusters", "--port", str(e2e_port)])
        ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
        assert expected_cluster_id in ids

    def test_describe_db_clusters(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-rds-describe-cluster"
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

        # Act
        result = runner.invoke(
            app,
            [
                "rds",
                "describe-db-clusters",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["rds", "describe-db-clusters", "--port", str(e2e_port)])
        ids = [c["DBClusterIdentifier"] for c in verify["DBClusters"]]
        assert cluster_id in ids
