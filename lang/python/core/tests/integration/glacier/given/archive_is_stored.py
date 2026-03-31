"""Given: the "glacier" "archive" was "STORED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "archive" was "STORED"')
def archive_is_stored():
    """No-op: uploaded archives are always in STORED state."""
