"""Given: the "s3" "upload" had no parts"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "upload" had no parts')
def upload_has_no_parts():
    """No-op: freshly created upload has no parts."""
