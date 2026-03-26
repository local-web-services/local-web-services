"""Given: a multipart upload has been completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a multipart upload has been completed")
def glacier_seq_multipart_upload_completed():
    pytest.skip("Cannot complete a multipart upload without parts in lws")
