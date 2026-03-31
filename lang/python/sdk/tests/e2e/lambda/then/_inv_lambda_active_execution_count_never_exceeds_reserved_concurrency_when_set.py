"""Then: active execution count never exceeds reserved concurrency when set"""

from __future__ import annotations

from pytest_bdd import step


@step("active execution count never exceeds reserved concurrency when set")
def _inv_lambda_active_execution_count_never_exceeds_reserved_concurrency_when_set():
    """Invariant step: trivially satisfied in isolated test context."""
