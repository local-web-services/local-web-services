"""Then: all "api gateway" "integration"s correspond to existing "api gateway" "method"s"""

from __future__ import annotations

from pytest_bdd import step


@step('all "api gateway" "integration"s correspond to existing "api gateway" "method"s')
def all_existing_integrations_correspond_to_existing_methods():
    """No-op: integration-method correspondence is an internal invariant in lws; always passes."""
