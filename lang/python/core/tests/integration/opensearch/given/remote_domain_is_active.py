"""Given: the remote "opensearch" "domain" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the remote "opensearch" "domain" was "ACTIVE"')
def remote_domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""
