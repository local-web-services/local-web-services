"""Given: the "s3 tables" "namespace" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "namespace" was "ACTIVE"')
@given('the "s3 tables" "namespace" will be "ACTIVE"')
def namespace_is_active():
    """No-op: in lws, namespaces are ACTIVE immediately after creation."""
