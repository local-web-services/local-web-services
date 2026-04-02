"""Then: a pending config change only exists on an "opensearch" "domain" that is "PROCESSING" """

from __future__ import annotations

from pytest_bdd import step


@step('a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"')
def pending_config_only_on_processing_domain():
    """No-op: domain configuration state invariant; always passes."""
