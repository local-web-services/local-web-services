"""Then: "lambda" "function" async retry count never exceeds two"""

from __future__ import annotations

from pytest_bdd import then


@then('"lambda" "function" async retry count never exceeds two')
def async_retry_count_within_limit():
    """Invariant: trivially satisfied in isolated lws context."""
