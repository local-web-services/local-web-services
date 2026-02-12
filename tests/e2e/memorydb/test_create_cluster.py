from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateCluster:
    def test_create_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_name = "e2e-create-memorydb"
        expected_status = "available"

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
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

    def test_describe_clusters(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_name = "e2e-describe-memorydb"
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

        # Act
        result = runner.invoke(
            app,
            [
                "memorydb",
                "describe-clusters",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["memorydb", "describe-clusters", "--port", str(e2e_port)])
        actual_names = [c["Name"] for c in verify["Clusters"]]
        assert cluster_name in actual_names

    def test_delete_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_name = "e2e-delete-memorydb"
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

        # Act
        result = runner.invoke(
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

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["memorydb", "describe-clusters", "--port", str(e2e_port)])
        actual_names = [c["Name"] for c in verify["Clusters"]]
        assert cluster_name not in actual_names
