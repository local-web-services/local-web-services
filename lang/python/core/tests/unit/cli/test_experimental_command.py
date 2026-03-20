"""Unit tests for is_experimental_command."""

from __future__ import annotations


class TestIsExperimentalCommand:
    def test_command_in_experimental_service_returns_true(self):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_SERVICES, is_experimental_command

        EXPERIMENTAL_SERVICES.add("test-service")

        # Act
        actual = is_experimental_command("test-service", "some-command")

        # Assert
        assert actual is True, "Expected value to be truthy"

        # Cleanup
        EXPERIMENTAL_SERVICES.discard("test-service")

    def test_command_in_stable_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_command

        # Act
        actual = is_experimental_command("chaos", "enable")

        # Assert
        assert actual is False, "Expected value to be truthy"

    def test_explicit_experimental_command(self):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_COMMANDS, is_experimental_command

        EXPERIMENTAL_COMMANDS.add(("chaos", "test-cmd"))

        # Act
        actual = is_experimental_command("chaos", "test-cmd")

        # Assert
        assert actual is True, "Expected value to be truthy"

        # Cleanup
        EXPERIMENTAL_COMMANDS.discard(("chaos", "test-cmd"))
