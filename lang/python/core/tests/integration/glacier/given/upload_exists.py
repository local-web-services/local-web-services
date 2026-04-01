"""Given: the "glacier" "upload" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "upload" existed')
def upload_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
