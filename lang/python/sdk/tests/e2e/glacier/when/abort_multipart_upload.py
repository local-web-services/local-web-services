"""When: a multipart upload is aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a multipart upload is aborted")
def abort_multipart_upload(lws_session, world):
    pytest.skip("Cannot abort a multipart upload without an upload ID in lws")
