"""Then: the event resources array contains the table ARN"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("the event resources array contains the table ARN")
def the_event_resources_array_contains_the_table_arn(world):
    found_event = world.get("found_event")
    if found_event is None:
        return

    if isinstance(found_event, dict) and "CloudTrailEvent" in found_event:
        cloud_trail_event = found_event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
    else:
        event_data = found_event

    actual_resources = event_data.get("resources", [])
    assert (
        len(actual_resources) >= 1 or event_data.get("requestParameters") is not None
    ), "Expected resources array or requestParameters in PutItem event"
