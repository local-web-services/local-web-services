from __future__ import annotations

import json

import pytest
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


@pytest.mark.skipif(
    not pytest.importorskip("docker", reason="Docker SDK required"),
    reason="Docker SDK not available",
)
class TestGremlinEndpoint:
    def test_cluster_endpoint_points_to_data_plane(self, e2e_port, lws_invoke, assert_invoke):
        """Created Neptune cluster endpoint should reference the data-plane port."""
        # Arrange
        cluster_id = "e2e-neptune-gremlin"

        # Act
        result = runner.invoke(
            app,
            [
                "neptune",
                "create-db-cluster",
                "--db-cluster-identifier",
                cluster_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        actual_endpoint = body["DBCluster"]["Endpoint"]
        expected_port = str(e2e_port + 23)
        assert expected_port in actual_endpoint
