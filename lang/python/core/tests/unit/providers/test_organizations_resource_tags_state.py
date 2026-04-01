"""Tests for _OrganizationsState.resource_tags property."""

from __future__ import annotations

from lws.providers.organizations._org_state import _OrganizationsState


class TestResourceTagsState:
    def test_resource_tags_initial_empty(self) -> None:
        # Arrange
        state = _OrganizationsState()

        # Act
        actual_tags = state.resource_tags

        # Assert
        expected_tags: dict = {}
        assert actual_tags == expected_tags

    def test_resource_tags_set_and_retrieve(self) -> None:
        # Arrange
        state = _OrganizationsState()
        expected_tags = {"env": "prod", "team": "payments"}

        # Act
        state.resource_tags["111111111111"] = expected_tags
        actual_tags = state.resource_tags.get("111111111111")

        # Assert
        assert actual_tags == expected_tags

    def test_resource_tags_reset_clears_entries(self) -> None:
        # Arrange
        state = _OrganizationsState()
        state.resource_tags["222222222222"] = {"env": "dev"}

        # Act
        state.reset()
        actual_tags = state.resource_tags

        # Assert
        expected_tags: dict = {}
        assert actual_tags == expected_tags

    def test_resource_tags_multiple_resources_isolated(self) -> None:
        # Arrange
        state = _OrganizationsState()
        state.resource_tags["111111111111"] = {"env": "prod"}
        state.resource_tags["ou-abc-12345678"] = {"team": "security"}

        # Act
        actual_account_tags = state.resource_tags.get("111111111111")
        actual_ou_tags = state.resource_tags.get("ou-abc-12345678")

        # Assert
        expected_account_tags = {"env": "prod"}
        expected_ou_tags = {"team": "security"}
        assert actual_account_tags == expected_account_tags
        assert actual_ou_tags == expected_ou_tags
