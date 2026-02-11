"""Tests for create_docker_client from_env fast path."""

from __future__ import annotations

from unittest.mock import MagicMock, patch


class TestCreateDockerClientFromEnv:
    """Test that from_env() is tried first."""

    def test_returns_client_when_from_env_succeeds(self):
        # Arrange
        expected_client = MagicMock()
        expected_client.ping.return_value = True
        mock_docker = MagicMock()
        mock_docker.from_env.return_value = expected_client

        with patch.dict("sys.modules", {"docker": mock_docker}):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is expected_client
        mock_docker.from_env.assert_called_once()

    def test_from_env_ping_failure_falls_through(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("connection refused")

        mock_sock_client = MagicMock()
        mock_sock_client.ping.return_value = True

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.DockerClient.return_value = mock_sock_client

        sock_path = tmp_path / ".colima" / "default" / "docker.sock"
        sock_path.parent.mkdir(parents=True)
        sock_path.touch()

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch("pathlib.Path.home", return_value=tmp_path),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is mock_sock_client
