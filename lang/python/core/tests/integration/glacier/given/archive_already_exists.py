"""Given: the "glacier" "archive" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "archive" already existed')
def archive_already_exists(world):
    pytest.skip(
        "UploadArchive always creates a new archive with a unique ID in lws; "
        "duplicate archive creation cannot be tested in stateless integration tests."
    )
