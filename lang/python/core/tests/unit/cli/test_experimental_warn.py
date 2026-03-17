"""Unit tests for warn_if_experimental."""

from __future__ import annotations


class TestWarnIfExperimental:
    def test_warns_for_experimental_service(self, capsys):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_SERVICES, warn_if_experimental

        EXPERIMENTAL_SERVICES.add("test-service")

        # Act
        warn_if_experimental("test-service")

        # Assert
        expected_warning = "Warning: 'test-service' is experimental and may change."
        actual_stderr = capsys.readouterr().err
        assert expected_warning in actual_stderr

        # Cleanup
        EXPERIMENTAL_SERVICES.discard("test-service")

    def test_no_warning_for_stable_service(self, capsys):
        # Arrange
        from lws.cli.experimental import warn_if_experimental

        # Act
        warn_if_experimental("chaos")

        # Assert
        actual_stderr = capsys.readouterr().err
        assert actual_stderr == ""

    def test_warns_for_explicit_experimental_command(self, capsys):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_COMMANDS, warn_if_experimental

        EXPERIMENTAL_COMMANDS.add(("chaos", "test-cmd"))

        # Act
        warn_if_experimental("chaos", "test-cmd")

        # Assert
        expected_warning = "Warning: 'chaos test-cmd' is experimental and may change."
        actual_stderr = capsys.readouterr().err
        assert expected_warning in actual_stderr

        # Cleanup
        EXPERIMENTAL_COMMANDS.discard(("chaos", "test-cmd"))

    def test_service_warning_when_command_not_in_explicit_set(self, capsys):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_SERVICES, warn_if_experimental

        EXPERIMENTAL_SERVICES.add("test-service")

        # Act
        warn_if_experimental("test-service", "some-command")

        # Assert
        expected_warning = "Warning: 'test-service' is experimental and may change."
        actual_stderr = capsys.readouterr().err
        assert expected_warning in actual_stderr

        # Cleanup
        EXPERIMENTAL_SERVICES.discard("test-service")
