"""Then: each element in Records is a valid CloudTrail event"""

from __future__ import annotations

from pytest_bdd import then

REQUIRED_CLOUDTRAIL_KEYS = {"eventVersion", "eventSource", "eventName", "eventTime"}


@then("each element in Records is a valid CloudTrail event")
def each_element_in_records_is_a_valid_cloudtrail_event(world):
    log_content = world.get("log_content")
    if log_content is None:
        return
    records = log_content.get("Records", [])
    for record in records:
        actual_keys = set(record.keys())
        missing_keys = REQUIRED_CLOUDTRAIL_KEYS - actual_keys
        assert not missing_keys, (
            f"Expected CloudTrail event to have keys {REQUIRED_CLOUDTRAIL_KEYS} "
            f"but missing: {missing_keys}"
        )
