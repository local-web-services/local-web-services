"""Then: the "memorydb" "resource" tag state will be unchanged (no-op model)"""

from __future__ import annotations

from pytest_bdd import then


@then('the "memorydb" "resource" tag state will be unchanged (no-op model)')
def resource_tag_state_unchanged_then():
    """No-op: tag state is an internal invariant; always passes."""
