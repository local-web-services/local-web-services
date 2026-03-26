"""Given: a multipart upload has been aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a multipart upload has been aborted")
def glacier_seq_multipart_upload_aborted():
    pytest.skip("Cannot abort a multipart upload without an upload ID in lws")
