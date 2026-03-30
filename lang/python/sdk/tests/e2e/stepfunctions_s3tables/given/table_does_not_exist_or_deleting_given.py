"""Given: the table does not exist or is "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the table does not exist or is "DELETING"')
def table_does_not_exist_or_deleting_given():
    """No-op: fresh state has no S3 Tables table buckets."""
