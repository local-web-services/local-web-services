from __future__ import annotations

from lws.providers._shared.response_helpers import xml_response


class TestXmlResponseWrapsPayload:
    def test_xml_response_wraps_payload(self) -> None:
        # Arrange
        expected_action = "DescribeDBClusters"
        expected_field = "Identifier"
        expected_value = "my-cluster"
        expected_status_code = 200
        expected_root_open = f"<{expected_action}Response>"
        expected_result_open = f"<{expected_action}Result>"

        # Act
        actual = xml_response(expected_action, {expected_field: expected_value})

        # Assert
        actual_body = actual.body.decode()
        assert (
            actual.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual.status_code!r}"
        assert (
            expected_root_open in actual_body
        ), f"Expected {expected_root_open!r} to be in {actual_body!r}"
        assert (
            expected_result_open in actual_body
        ), f"Expected {expected_result_open!r} to be in {actual_body!r}"
        assert (
            f"<{expected_field}>{expected_value}</{expected_field}>" in actual_body
        ), f"Expected field element to be in {actual_body!r}"
