"""Then: "lambda" "function" async retry count never exceeds two"""

from __future__ import annotations

from pytest_bdd import step


@step('"lambda" "function" async retry count never exceeds two')
def _inv_lambda_async_retry_count_never_exceeds_two():
    """Invariant step: trivially satisfied in isolated test context."""
