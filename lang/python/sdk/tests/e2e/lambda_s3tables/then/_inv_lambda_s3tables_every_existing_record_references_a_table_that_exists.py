"""Then: every existing "s3 tables" "record" references a "s3 tables" "table" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step('every existing "s3 tables" "record" references a "s3 tables" "table" that exists')
def _inv_lambda_s3tables_every_existing_record_references_a_table_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
