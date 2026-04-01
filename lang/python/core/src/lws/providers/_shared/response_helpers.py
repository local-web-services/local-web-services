"""Shared HTTP response helpers for AWS-style JSON APIs.

Includes helpers for lifecycle state guards used by DB service providers.
"""

from __future__ import annotations

import json
import uuid
import xml.etree.ElementTree as ET
from datetime import UTC, datetime

from starlette.responses import Response


def json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response with the standard AWS media type."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def error_response(
    code: str,
    message: str,
    *,
    status_code: int = 400,
    message_key: str = "Message",
) -> Response:
    """Return an error response in AWS JSON format."""
    error_body = {"__type": code, message_key: message}
    return json_response(error_body, status_code=status_code)


def iso_now() -> str:
    """Return the current UTC time in ISO 8601 format."""
    return datetime.now(UTC).strftime("%Y-%m-%dT%H:%M:%S.000Z")


def parse_endpoint(endpoint: str) -> tuple[str, int]:
    """Split a ``host:port`` endpoint string into ``(host, port)``."""
    host, port_str = endpoint.rsplit(":", 1)
    return host, int(port_str)


def _member_name(key: str) -> str:
    """Derive the XML list-member element name from the list wrapper key."""
    if key.endswith("List"):
        return key[:-4]
    if len(key) > 1 and key.endswith("s"):
        return key[:-1]
    return "member"


def _dict_to_xml(parent: ET.Element, data: dict) -> None:
    """Recursively populate an XML element from a dict."""
    for key, value in data.items():
        if isinstance(value, list):
            list_elem = ET.SubElement(parent, key)
            member = _member_name(key)
            for item in value:
                item_elem = ET.SubElement(list_elem, member)
                if isinstance(item, dict):
                    _dict_to_xml(item_elem, item)
                else:
                    item_elem.text = str(item) if item is not None else ""
        elif isinstance(value, dict):
            nested = ET.SubElement(parent, key)
            _dict_to_xml(nested, value)
        else:
            elem = ET.SubElement(parent, key)
            elem.text = str(value) if value is not None else ""


def xml_response(action: str, payload_dict: dict, status_code: int = 200) -> Response:
    """Return an AWS query-protocol XML response.

    Wraps *payload_dict* in the standard ``<{action}Response><{action}Result>``
    envelope that boto3 expects for services using the ``query`` protocol.
    """
    root = ET.Element(f"{action}Response")
    result_elem = ET.SubElement(root, f"{action}Result")
    _dict_to_xml(result_elem, payload_dict)
    metadata = ET.SubElement(root, "ResponseMetadata")
    ET.SubElement(metadata, "RequestId").text = str(uuid.uuid4())
    return Response(
        content=ET.tostring(root, encoding="unicode"),
        status_code=status_code,
        media_type="text/xml",
    )


def xml_error_response(code: str, message: str) -> Response:
    """Return an AWS query-protocol XML error response."""
    root = ET.Element("ErrorResponse")
    error = ET.SubElement(root, "Error")
    ET.SubElement(error, "Code").text = code
    ET.SubElement(error, "Message").text = message
    ET.SubElement(root, "RequestId").text = str(uuid.uuid4())
    return Response(
        content=ET.tostring(root, encoding="unicode"),
        status_code=400,
        media_type="text/xml",
    )


def creating_guard(
    resource_id: str,
    fault_code: str,
    resource_type: str,
    current_state: str | None,
) -> Response | None:
    """Return an error response if *current_state* is ``"CREATING"``, else None."""
    if current_state == "CREATING":
        return error_response(
            fault_code,
            f"{resource_type} {resource_id} is still being created",
            status_code=400,
        )
    return None
