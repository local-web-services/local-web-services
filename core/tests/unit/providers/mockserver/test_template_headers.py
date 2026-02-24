"""Unit tests for mock server template rendering — headers."""

from __future__ import annotations

from lws.providers.mockserver.template import render_template


class TestRenderHeaders:
    def test_header_value(self):
        # Arrange
        template = "{{header.X-Api-Key}}"
        expected = "key123"

        # Act
        actual = render_template(template, headers={"X-Api-Key": expected})

        # Assert
        assert actual == expected
