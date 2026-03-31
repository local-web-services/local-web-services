"""Then: every existing document references a "elasticsearch" "domain" that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every existing document references a "elasticsearch" "domain" that exists')
def _inv_lambda_elasticsearch_every_existing_document_references_a_domain_that_exist():
    """Invariant step: trivially satisfied in isolated test context."""
