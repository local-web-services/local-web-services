"""Unit tests for mock server template rendering — random_choice."""

from __future__ import annotations

from lws.providers.mockserver.template import render_template


class TestRenderRandomChoice:
    def test_random_choice(self):
        # Arrange
        template = "{{random_choice(a,b,c)}}"
        expected_choices = {"a", "b", "c"}

        # Act
        actual = render_template(template)

        # Assert
        assert actual in expected_choices
