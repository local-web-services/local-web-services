"""Unit tests for fake server template rendering — headers."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderHeaders:
    def test_header_value(self):
        # Arrange
        template = "{{header.X-Api-Key}}"
        expected = "key123"

        # Act
        actual = render_template(template, headers={"X-Api-Key": expected})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"
