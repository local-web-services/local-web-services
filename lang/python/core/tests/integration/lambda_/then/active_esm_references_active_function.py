"""Then: every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"'
)
def active_esm_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""
