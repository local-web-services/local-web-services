"""Given: the "glacier" "upload" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "upload" already existed')
def upload_already_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
