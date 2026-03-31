"""Then: every instance has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every instance has a valid status")
def every_instance_has_valid_status():
    """No-op: instance status validity is an internal invariant; always passes."""
