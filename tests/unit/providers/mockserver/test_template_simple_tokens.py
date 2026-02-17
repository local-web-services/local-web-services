"""Unit tests for mock server template rendering — simple tokens."""

from __future__ import annotations

import re

from lws.providers.mockserver.template import render_template


class TestRenderSimpleTokens:
    def test_uuid_token(self):
        # Arrange
        template = "{{uuid}}"
        uuid_pattern = r"^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"

        # Act
        actual = render_template(template)

        # Assert
        assert re.match(uuid_pattern, actual)

    def test_timestamp_token(self):
        # Arrange
        template = "{{timestamp}}"

        # Act
        actual = render_template(template)

        # Assert
        assert "T" in actual
        assert actual.endswith("+00:00")

    def test_timestamp_epoch_token(self):
        # Arrange
        template = "{{timestamp_epoch}}"

        # Act
        actual = render_template(template)

        # Assert
        assert actual.isdigit()

    def test_unknown_token_preserved(self):
        # Arrange
        template = "{{unknown_token}}"
        expected = "{{unknown_token}}"

        # Act
        actual = render_template(template)

        # Assert
        assert actual == expected
