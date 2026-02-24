"""Tests for create_docker_client from_env fast path."""

from __future__ import annotations

from unittest.fake import MagicFake, patch


class TestCreateDockerClientFromEnv:
    """Test that from_env() is tried first."""

    def test_returns_client_when_from_env_succeeds(self):
        # Arrange
        expected_client = MagicFake()
        expected_client.ping.return_value = True
        fake_docker = MagicFake()
        fake_docker.from_env.return_value = expected_client

        with patch.dict("sys.modules", {"docker": fake_docker}):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is expected_client
        fake_docker.from_env.assert_called_once()

    def test_from_env_ping_failure_falls_through(self, tmp_path):
        # Arrange
        fake_env_client = MagicFake()
        fake_env_client.ping.side_effect = Exception("connection refused")

        fake_sock_client = MagicFake()
        fake_sock_client.ping.return_value = True

        fake_docker = MagicFake()
        fake_docker.from_env.return_value = fake_env_client
        fake_docker.DockerClient.return_value = fake_sock_client

        sock_path = tmp_path / "docker.sock"
        sock_path.touch()

        with (
            patch.dict("sys.modules", {"docker": fake_docker}),
            patch(
                "lws.providers.lambda_runtime.docker._socket_candidates",
                return_value=[sock_path],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is fake_sock_client
