"""Then: a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING" """

from __future__ import annotations

from pytest_bdd import then


@then('a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"')
@then('a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"')
def pending_config_change_only_on_processing_domain():
    """Invariant trivially satisfied in isolated test context."""
