"""Given: the upload already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload already exists")
def upload_already_exists():
    pytest.skip("Cannot create a multipart upload as a precondition in this context")
