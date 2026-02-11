"""Tests for create_docker_client when no Docker daemon is reachable."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest


class TestCreateDockerClientNoDocker:
    """Test error when no Docker daemon is reachable."""

    def test_raises_when_no_sockets_found(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("no daemon")

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.errors.DockerException = type("DockerException", (Exception,), {})

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch(
                "lws.providers.lambda_runtime.docker._socket_candidates",
                return_value=[tmp_path / "nonexistent.sock"],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act / Assert
            with pytest.raises(Exception, match="Cannot connect to Docker daemon"):
                create_docker_client()
