"""Given: the "glacier" "upload" will be "InProgress" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "upload" will be "InProgress"')
def upload_is_in_progress(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
