"""Given: the "s3 tables" "bucket" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" was not "CREATING"')
def bucket_is_not_creating_given():
    """No-op: buckets are not in CREATING state by default."""
