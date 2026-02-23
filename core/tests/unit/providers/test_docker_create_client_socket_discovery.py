"""Tests for create_docker_client socket discovery fallback."""

from __future__ import annotations

from unittest.mock import MagicMock, patch


class TestCreateDockerClientSocketDiscovery:
    """Test that well-known socket paths are probed."""

    def test_colima_default_socket(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("no daemon")

        mock_sock_client = MagicMock()
        mock_sock_client.ping.return_value = True

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.DockerClient.return_value = mock_sock_client

        expected_sock = tmp_path / ".colima" / "default" / "docker.sock"
        expected_sock.parent.mkdir(parents=True)
        expected_sock.touch()

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch(
                "lws.providers._shared.docker_client._socket_candidates",
                return_value=[expected_sock],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is mock_sock_client
        mock_docker.DockerClient.assert_called_once_with(base_url=f"unix://{expected_sock}")

    def test_rancher_desktop_socket(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("no daemon")

        mock_sock_client = MagicMock()
        mock_sock_client.ping.return_value = True

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.DockerClient.return_value = mock_sock_client

        expected_sock = tmp_path / ".rd" / "docker.sock"
        expected_sock.parent.mkdir(parents=True)
        expected_sock.touch()

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch(
                "lws.providers._shared.docker_client._socket_candidates",
                return_value=[expected_sock],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is mock_sock_client
        mock_docker.DockerClient.assert_called_once_with(base_url=f"unix://{expected_sock}")

    def test_docker_desktop_socket(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("no daemon")

        mock_sock_client = MagicMock()
        mock_sock_client.ping.return_value = True

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.DockerClient.return_value = mock_sock_client

        expected_sock = tmp_path / ".docker" / "run" / "docker.sock"
        expected_sock.parent.mkdir(parents=True)
        expected_sock.touch()

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch(
                "lws.providers._shared.docker_client._socket_candidates",
                return_value=[expected_sock],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is mock_sock_client
        mock_docker.DockerClient.assert_called_once_with(base_url=f"unix://{expected_sock}")

    def test_skips_socket_that_exists_but_fails_ping(self, tmp_path):
        # Arrange
        mock_env_client = MagicMock()
        mock_env_client.ping.side_effect = Exception("no daemon")

        mock_bad_client = MagicMock()
        mock_bad_client.ping.side_effect = Exception("socket broken")

        mock_good_client = MagicMock()
        mock_good_client.ping.return_value = True

        mock_docker = MagicMock()
        mock_docker.from_env.return_value = mock_env_client
        mock_docker.DockerClient.side_effect = [mock_bad_client, mock_good_client]

        bad_sock = tmp_path / "bad.sock"
        bad_sock.touch()

        good_sock = tmp_path / "good.sock"
        good_sock.touch()

        with (
            patch.dict("sys.modules", {"docker": mock_docker}),
            patch(
                "lws.providers._shared.docker_client._socket_candidates",
                return_value=[bad_sock, good_sock],
            ),
        ):
            from lws.providers.lambda_runtime.docker import create_docker_client

            # Act
            actual_client = create_docker_client()

        # Assert
        assert actual_client is mock_good_client
