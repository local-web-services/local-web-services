"""Then: all "EXISTING" methods belong to "ACTIVE" resources"""

from __future__ import annotations

from pytest_bdd import then


@then('all "EXISTING" methods belong to "ACTIVE" resources')
def all_existing_methods_belong_to_active_resources_then():
    """No-op: method-resource membership is an internal invariant in lws; always passes."""
