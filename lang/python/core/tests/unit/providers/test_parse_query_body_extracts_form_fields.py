from __future__ import annotations

import pytest

from lws.providers._shared.request_helpers import parse_query_body

from ._helpers import FakeRequest


class TestParseQueryBodyExtractsFormFields:
    @pytest.mark.asyncio
    async def test_parse_query_body_extracts_form_fields(self) -> None:
        # Arrange
        expected_action = "CreateDBCluster"
        expected_version = "2014-10-31"
        raw_body = b"Action=CreateDBCluster&Version=2014-10-31"
        request = FakeRequest(raw_body)

        # Act
        actual = await parse_query_body(request)

        # Assert
        assert (
            actual["Action"] == expected_action
        ), f"Expected {expected_action!r} but got {actual['Action']!r}"
        assert (
            actual["Version"] == expected_version
        ), f"Expected {expected_version!r} but got {actual['Version']!r}"
