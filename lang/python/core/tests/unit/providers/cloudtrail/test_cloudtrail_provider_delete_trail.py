"""Tests for CloudTrailProvider DeleteTrail."""

from __future__ import annotations

import pytest

from lws.providers.cloudtrail.provider import CloudTrailProvider


class TestCloudTrailProviderDeleteTrail:
    """DeleteTrail: removal and error cases."""

    def test_delete_trail_removes_it(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")

        # Act
        provider.delete_trail("trail")

        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.get_trail("trail")

    def test_delete_trail_missing_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()

        # Act
        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.delete_trail("no-such-trail")

    def test_delete_trail_frees_capacity(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(5):
            provider.create_trail(f"trail-{i}", "bucket")

        # Act
        provider.delete_trail("trail-0")
        actual = provider.create_trail("trail-new", "bucket")

        # Assert
        assert actual.name == "trail-new"

    def test_deleted_trail_not_in_list(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")

        # Act
        provider.delete_trail("trail")
        actual = provider.list_trails()

        # Assert
        expected_names = []
        actual_names = [t.name for t in actual]
        assert actual_names == expected_names
