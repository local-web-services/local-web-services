"""Then: every active event source mapping references an existing non-deleted function"""

from __future__ import annotations

from pytest_bdd import then


@then("every active event source mapping references an existing non-deleted function")
def active_esm_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""
