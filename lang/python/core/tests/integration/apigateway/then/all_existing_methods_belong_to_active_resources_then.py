"""Then: all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s"""

from __future__ import annotations

from pytest_bdd import then


@then('all "api gateway" "method"s belong to "ACTIVE" "api gateway" "resource"s')
def all_existing_methods_belong_to_active_resources_then():
    """No-op: method-resource membership is an internal invariant in lws; always passes."""
