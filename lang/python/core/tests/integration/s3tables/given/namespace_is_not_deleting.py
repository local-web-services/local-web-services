"""Given: the "s3 tables" "namespace" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "namespace" was not "DELETING"')
def namespace_is_not_deleting():
    """No-op: in lws, namespaces are not in DELETING state by default."""
