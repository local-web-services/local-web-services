"""Given: the "s3 tables" "bucket" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" was not "DELETING"')
def bucket_is_not_deleting():
    """No-op: in lws, buckets are not in DELETING state by default."""
