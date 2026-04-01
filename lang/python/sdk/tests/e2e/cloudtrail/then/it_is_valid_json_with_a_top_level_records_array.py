"""Then: it is valid JSON with a top-level Records array"""

from __future__ import annotations

from pytest_bdd import then


@then("it is valid JSON with a top-level Records array")
def it_is_valid_json_with_a_top_level_records_array(world):
    log_content = world.get("log_content")
    if log_content is None:
        return
    assert isinstance(
        log_content, dict
    ), f"Expected JSON dict at top level but got {type(log_content)}"
    assert (
        "Records" in log_content
    ), f"Expected 'Records' key in log JSON but got keys: {list(log_content.keys())}"
    assert isinstance(
        log_content["Records"], list
    ), f"Expected 'Records' to be a list but got {type(log_content['Records'])}"
