"""Given: the archive is "STORED" """

from __future__ import annotations

from pytest_bdd import given


@given('the archive is "STORED"')
def archive_is_stored_given():
    """No-op: archives are STORED immediately after upload in lws."""
