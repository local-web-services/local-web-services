"""Unit tests for fake server template rendering — query params."""

from __future__ import annotations

from lws.providers.fakeserver.template import render_template


class TestRenderQueryParams:
    def test_query_param(self):
        # Arrange
        template = "{{query.page}}"
        expected = "5"

        # Act
        actual = render_template(template, query_params={"page": expected})

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"
