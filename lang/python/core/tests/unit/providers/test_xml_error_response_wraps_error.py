from __future__ import annotations

from lws.providers._shared.response_helpers import xml_error_response


class TestXmlErrorResponseWrapsError:
    def test_xml_error_response_wraps_error(self) -> None:
        # Arrange
        expected_code = "DBClusterNotFoundFault"
        expected_message = "Cluster not found"
        expected_status_code = 400
        expected_code_element = f"<Code>{expected_code}</Code>"
        expected_message_element = f"<Message>{expected_message}</Message>"

        # Act
        actual = xml_error_response(expected_code, expected_message)

        # Assert
        actual_body = actual.body.decode()
        assert (
            actual.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual.status_code!r}"
        assert (
            expected_code_element in actual_body
        ), f"Expected {expected_code_element!r} to be in {actual_body!r}"
        assert (
            expected_message_element in actual_body
        ), f"Expected {expected_message_element!r} to be in {actual_body!r}"
