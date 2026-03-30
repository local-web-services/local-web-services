"""AWS CloudTrail action handler functions."""

from __future__ import annotations

from typing import Any

from fastapi import Response

from lws.providers.cloudtrail._cloudtrail_helpers import _error_response, _json_response
from lws.providers.cloudtrail._cloudtrail_state import _CloudTrailState, _trail_arn


async def _handle_create_trail(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle CreateTrail — create a new trail."""
    name = body.get("Name", "")
    s3_bucket = body.get("S3BucketName", "")

    if name in state.trails:
        state.record_event("CreateTrail")
        return _error_response(
            "TrailAlreadyExistsException",
            f"Trail '{name}' already exists.",
            status_code=409,
        )

    arn = _trail_arn(name)
    trail = {
        "Name": name,
        "S3BucketName": s3_bucket,
        "TrailARN": arn,
        "HomeRegion": "us-east-1",
        "HasCustomEventSelectors": False,
        "IsMultiRegionTrail": False,
    }
    state.trails[name] = trail
    state.set_logging(name, False)
    state.record_event("CreateTrail")
    return _json_response(trail)


async def _handle_delete_trail(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle DeleteTrail — remove a trail."""
    name = body.get("Name", "")

    if name not in state.trails:
        state.record_event("DeleteTrail")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )

    del state.trails[name]
    state.set_logging(name, False)
    state.record_event("DeleteTrail")
    return _json_response({})


async def _handle_describe_trails(
    state: _CloudTrailState, _body: dict, _tracker: object = None
) -> Response:
    """Handle DescribeTrails — return all trails."""
    state.record_event("DescribeTrails")
    return _json_response({"trailList": list(state.trails.values())})


async def _handle_get_trail(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle GetTrail — return a single trail by name or ARN."""
    name = body.get("Name", "")

    trail = state.trails.get(name)
    if trail is None:
        state.record_event("GetTrail")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    state.record_event("GetTrail")
    return _json_response({"Trail": trail})


async def _handle_get_trail_status(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle GetTrailStatus — return logging state for a trail."""
    name = body.get("Name", "")

    if name not in state.trails:
        state.record_event("GetTrailStatus")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    state.record_event("GetTrailStatus")
    return _json_response(
        {
            "IsLogging": state.logging_enabled(name),
            "LatestDeliveryError": "",
            "LatestNotificationError": "",
        }
    )


async def _handle_start_logging(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle StartLogging — enable logging on a trail."""
    name = body.get("Name", "")

    if name not in state.trails:
        state.record_event("StartLogging")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    state.set_logging(name, True)
    state.record_event("StartLogging")
    return _json_response({})


async def _handle_stop_logging(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle StopLogging — disable logging on a trail."""
    name = body.get("Name", "")

    if name not in state.trails:
        state.record_event("StopLogging")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    state.set_logging(name, False)
    state.record_event("StopLogging")
    return _json_response({})


async def _handle_put_event_selectors(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle PutEventSelectors — store event selectors for a trail."""
    name = body.get("TrailName", "")
    selectors = body.get("EventSelectors", [])

    if name not in state.trails:
        state.record_event("PutEventSelectors")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    state.set_event_selectors(name, selectors)
    arn = state.trails[name]["TrailARN"]
    state.record_event("PutEventSelectors")
    return _json_response(
        {
            "TrailARN": arn,
            "EventSelectors": selectors,
        }
    )


async def _handle_get_event_selectors(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle GetEventSelectors — return event selectors for a trail."""
    name = body.get("TrailName", "")

    if name not in state.trails:
        state.record_event("GetEventSelectors")
        return _error_response(
            "TrailNotFoundException",
            f"Trail '{name}' does not exist.",
        )
    arn = state.trails[name]["TrailARN"]
    selectors = state.get_event_selectors(name)
    state.record_event("GetEventSelectors")
    return _json_response(
        {
            "TrailARN": arn,
            "EventSelectors": selectors,
        }
    )


async def _handle_lookup_events(
    state: _CloudTrailState, body: dict, _tracker: object = None
) -> Response:
    """Handle LookupEvents — return filtered, paginated events."""
    lookup_attrs = body.get("LookupAttributes", [])
    max_results = body.get("MaxResults", None)

    events = list(state.events)

    for attr in lookup_attrs:
        attr_key = attr.get("AttributeKey", "")
        attr_value = attr.get("AttributeValue", "")
        if attr_key == "EventName":
            events = [e for e in events if e.get("EventName") == attr_value]

    next_token = None
    if max_results is not None and len(events) > max_results:
        events = events[:max_results]
        next_token = "lws-pagination-token"

    state.record_event("LookupEvents")
    result: dict[str, Any] = {"Events": events}
    if next_token is not None:
        result["NextToken"] = next_token
    return _json_response(result)


_ACTION_HANDLERS: dict[str, Any] = {
    "CreateTrail": _handle_create_trail,
    "DeleteTrail": _handle_delete_trail,
    "DescribeTrails": _handle_describe_trails,
    "GetTrail": _handle_get_trail,
    "GetTrailStatus": _handle_get_trail_status,
    "StartLogging": _handle_start_logging,
    "StopLogging": _handle_stop_logging,
    "PutEventSelectors": _handle_put_event_selectors,
    "GetEventSelectors": _handle_get_event_selectors,
    "LookupEvents": _handle_lookup_events,
}
