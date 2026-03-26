"""Given: the upload exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the upload exists")
def upload_exists():
    pytest.skip("Multipart upload is not supported by the lws glacier provider")
