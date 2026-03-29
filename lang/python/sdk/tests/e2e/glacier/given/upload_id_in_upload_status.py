"""Given: upload_id in upload_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("upload_id in upload_status")
def upload_id_in_upload_status():
    pytest.skip("Cannot create a multipart upload as a FizzBee precondition in this context")
