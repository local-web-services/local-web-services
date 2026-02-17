"""Unit tests for mock server template rendering — path params."""

from __future__ import annotations

from lws.providers.mockserver.template import render_template


class TestRenderPathParams:
    def test_path_param(self):
        # Arrange
        template = "{{path.user_id}}"
        expected = "usr_123"

        # Act
        actual = render_template(template, path_params={"user_id": expected})

        # Assert
        assert actual == expected

    def test_missing_path_param(self):
        # Arrange
        template = "{{path.missing}}"
        expected = ""

        # Act
        actual = render_template(template, path_params={"other": "val"})

        # Assert
        assert actual == expected
