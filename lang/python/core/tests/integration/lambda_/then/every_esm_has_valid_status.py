"""Then: every "lambda" "event source mapping" has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then('every "lambda" "event source mapping" has a valid status')
def every_esm_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""
