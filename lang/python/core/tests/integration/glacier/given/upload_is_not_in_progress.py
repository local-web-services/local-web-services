"""Given: the "glacier" "upload" was not "InProgress" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "upload" was not "InProgress"')
def upload_is_not_in_progress(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
