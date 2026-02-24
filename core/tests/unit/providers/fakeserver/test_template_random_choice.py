"""Unit tests for fake server template rendering — random_choice."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderRandomChoice:
    def test_random_choice(self):
        # Arrange
        template = "{{random_choice(a,b,c)}}"
        expected_choices = {"a", "b", "c"}

        # Act
        actual = render_template(template)

        # Assert
        assert actual in expected_choices
