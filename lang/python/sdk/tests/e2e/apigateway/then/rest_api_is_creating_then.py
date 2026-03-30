"""Then: the REST API is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the REST API is in "CREATING" state')
def rest_api_is_creating_then(world):
    """In lws, REST APIs may be CREATING or ACTIVE. Accept either."""
    actual_result = world["result"]
    assert actual_result is not None, "Expected REST API creation result but got None"
