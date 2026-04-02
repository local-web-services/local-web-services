"""Unit tests: extract_account_id_from_token falls back to default account."""

from __future__ import annotations

from lws.providers._shared.per_account_state import (
    DEFAULT_ACCOUNT_ID,
    extract_account_id_from_token,
)


class TestExtractAccountIdFromTokenFallback:
    def test_empty_token_returns_default_account(self) -> None:
        # Arrange
        token = ""

        # Act
        actual_account_id = extract_account_id_from_token(token)

        # Assert
        expected_account_id = DEFAULT_ACCOUNT_ID
        assert actual_account_id == expected_account_id

    def test_unknown_format_returns_default_account(self) -> None:
        # Arrange
        token = "some-other-token-format"

        # Act
        actual_account_id = extract_account_id_from_token(token)

        # Assert
        expected_account_id = DEFAULT_ACCOUNT_ID
        assert actual_account_id == expected_account_id

    def test_valid_token_returns_embedded_account(self) -> None:
        # Arrange
        token = "lws-acct-123456789012-some-uuid"

        # Act
        actual_account_id = extract_account_id_from_token(token)

        # Assert
        expected_account_id = "123456789012"
        assert actual_account_id == expected_account_id
