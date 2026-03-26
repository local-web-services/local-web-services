"""Given: the upload has no parts"""

from __future__ import annotations

from pytest_bdd import given


@given("the upload has no parts")
def upload_has_no_parts():
    """No-op: freshly created upload has no parts."""
