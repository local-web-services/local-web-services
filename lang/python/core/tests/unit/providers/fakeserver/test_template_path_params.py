"""Unit tests for fake server template rendering — path params."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderPathParams:
    def test_path_param(self):
        # Arrange
        template = "{{path.user_id}}"
        expected = "usr_123"

        # Act
        actual = render_template(template, path_params={"user_id": expected})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"

    def test_missing_path_param(self):
        # Arrange
        template = "{{path.missing}}"
        expected = ""

        # Act
        actual = render_template(template, path_params={"other": "val"})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"
