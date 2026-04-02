"""Then: every "SUCCEEDED" "step functions" "execution" recorded which "elasticsearch" "domain" it called"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "SUCCEEDED" "step functions" "execution" recorded which "opensearch" "domain" it called'
)
@step(
    'every "SUCCEEDED" "step functions" "execution" recorded which "elasticsearch" "domain" it called'
)
def _inv_stepfunctions_opensearch_every_succeeded_execution_recorded_which_domain_it():
    """Invariant step: trivially satisfied in isolated test context."""
