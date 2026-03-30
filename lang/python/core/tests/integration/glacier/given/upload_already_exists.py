"""Given: the upload already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload already exists")
def upload_already_exists(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
