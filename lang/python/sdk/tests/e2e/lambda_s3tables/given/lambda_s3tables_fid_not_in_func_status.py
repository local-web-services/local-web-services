"""Given: fid not in func_status"""

from __future__ import annotations

from pytest_bdd import given


@given("fid not in func_status")
def lambda_s3tables_fid_not_in_func_status():
    """No-op: fresh state has no functions."""
