"""Given: the upload exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload exists")
def upload_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
