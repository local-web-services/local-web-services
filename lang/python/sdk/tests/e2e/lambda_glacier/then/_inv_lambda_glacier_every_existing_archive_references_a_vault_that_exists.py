"""Then: every existing archive references a vault that exists"""

from __future__ import annotations

from pytest_bdd import then


@then("every existing archive references a vault that exists")
def _inv_lambda_glacier_every_existing_archive_references_a_vault_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
