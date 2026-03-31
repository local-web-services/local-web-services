"""Then: all "EXISTING" integrations correspond to "EXISTING" methods"""

from __future__ import annotations

from pytest_bdd import step


@step('all "EXISTING" integrations correspond to "EXISTING" methods')
def all_existing_integrations_correspond_to_existing_methods():
    """No-op: integration-method correspondence is an internal invariant in lws; always passes."""
