"""Given: the "glacier" "archive" was "STORED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "archive" was "STORED"')
def archive_is_stored_given():
    """No-op: archives are STORED immediately after upload in lws."""
