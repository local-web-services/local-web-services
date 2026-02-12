from __future__ import annotations

import pytest
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


@pytest.mark.skipif(
    not pytest.importorskip("docker", reason="Docker SDK required"),
    reason="Docker SDK not available",
)
class TestGremlinEndpoint:
    def test_cluster_endpoint_is_set(self, e2e_port, lws_invoke, assert_invoke, parse_output):
        """Created Neptune cluster should have an Endpoint field."""
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
        body = parse_output(result.output)
        actual_endpoint = body["DBCluster"]["Endpoint"]
        assert actual_endpoint, "Endpoint should be non-empty"
        assert "localhost" in actual_endpoint
