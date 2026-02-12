from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateCacheCluster:
    def test_create_cache_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-create-cache-cluster"
        expected_status = "available"

        # Act
        result = runner.invoke(
            app,
            [
                "elasticache",
                "create-cache-cluster",
                "--cache-cluster-id",
                cluster_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "elasticache",
                "describe-cache-clusters",
                "--cache-cluster-id",
                cluster_id,
                "--port",
                str(e2e_port),
            ]
        )
        actual_status = verify["CacheClusters"][0]["CacheClusterStatus"]
        assert actual_status == expected_status

    def test_describe_cache_clusters(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-describe-cache-clusters"
        lws_invoke(
            [
                "elasticache",
                "create-cache-cluster",
                "--cache-cluster-id",
                cluster_id,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "elasticache",
                "describe-cache-clusters",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["elasticache", "describe-cache-clusters", "--port", str(e2e_port)])
        actual_ids = [c["CacheClusterId"] for c in verify["CacheClusters"]]
        assert cluster_id in actual_ids

    def test_delete_cache_cluster(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        cluster_id = "e2e-delete-cache-cluster"
        lws_invoke(
            [
                "elasticache",
                "create-cache-cluster",
                "--cache-cluster-id",
                cluster_id,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "elasticache",
                "delete-cache-cluster",
                "--cache-cluster-id",
                cluster_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["elasticache", "describe-cache-clusters", "--port", str(e2e_port)])
        actual_ids = [c["CacheClusterId"] for c in verify["CacheClusters"]]
        assert cluster_id not in actual_ids
