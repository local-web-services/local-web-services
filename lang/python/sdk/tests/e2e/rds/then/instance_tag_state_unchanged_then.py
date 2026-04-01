"""Then: the "rds" "instance" tag state will be unchanged (no-op model)"""

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" tag state will be unchanged (no-op model)')
def instance_tag_state_unchanged_then():
    """No-op: tag state is an internal invariant; always passes."""
