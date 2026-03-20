"""Unit tests for fake server template rendering — body."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderBody:
    def test_body_dotpath(self):
        # Arrange
        template = "{{body.user.name}}"
        expected = "Alice"

        # Act
        actual = render_template(template, body={"user": {"name": expected}})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"

    def test_body_dotpath_missing(self):
        # Arrange
        template = "{{body.missing.field}}"
        expected = ""

        # Act
        actual = render_template(template, body={"other": "val"})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"
