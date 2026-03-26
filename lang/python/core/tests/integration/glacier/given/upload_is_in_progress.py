"""Given: the upload is InProgress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload is InProgress")
def upload_is_in_progress(world):
    pytest.skip("Multipart upload operations are not yet implemented in the lws Glacier provider.")
