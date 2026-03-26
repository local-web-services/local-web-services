"""When: a multipart upload is completed"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a multipart upload is completed")
def complete_multipart_upload(lws_session, world):
    pytest.skip("Cannot complete a multipart upload without parts in lws")
