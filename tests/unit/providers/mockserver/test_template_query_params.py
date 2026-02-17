"""Unit tests for mock server template rendering — query params."""

from __future__ import annotations

from lws.providers.mockserver.template import render_template


class TestRenderQueryParams:
    def test_query_param(self):
        # Arrange
        template = "{{query.page}}"
        expected = "5"

        # Act
        actual = render_template(template, query_params={"page": expected})

        # Assert
        assert actual == expected
