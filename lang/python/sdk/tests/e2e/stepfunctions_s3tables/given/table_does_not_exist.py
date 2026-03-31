"""Given: the table did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table did not exist")
def table_does_not_exist():
    """No-op: fresh state has no S3 Tables table buckets."""
