"""Unit tests for is_experimental_command."""

from __future__ import annotations


class TestIsExperimentalCommand:
    def test_command_in_experimental_service_returns_true(self):
        # Arrange
        from lws.cli.experimental import is_experimental_command

        # Act
        actual = is_experimental_command("neptune", "create-db-cluster")

        # Assert
        assert actual is True

    def test_command_in_stable_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_command

        # Act
        actual = is_experimental_command("dynamodb", "put-item")

        # Assert
        assert actual is False

    def test_explicit_experimental_command(self):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_COMMANDS, is_experimental_command

        EXPERIMENTAL_COMMANDS.add(("dynamodb", "test-cmd"))

        # Act
        actual = is_experimental_command("dynamodb", "test-cmd")

        # Assert
        assert actual is True

        # Cleanup
        EXPERIMENTAL_COMMANDS.discard(("dynamodb", "test-cmd"))
