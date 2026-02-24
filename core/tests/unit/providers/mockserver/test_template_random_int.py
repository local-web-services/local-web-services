"""Unit tests for mock server template rendering — random_int."""

from __future__ import annotations

from lws.providers.mockserver.template import render_template


class TestRenderRandomInt:
    def test_random_int_range(self):
        # Arrange
        template = "{{random_int(1,100)}}"

        # Act
        actual = render_template(template)

        # Assert
        assert 1 <= int(actual) <= 100
