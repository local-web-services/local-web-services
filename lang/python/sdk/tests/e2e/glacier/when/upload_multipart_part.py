"""When: a part is uploaded for a multipart upload"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a part is uploaded for a multipart upload")
def upload_multipart_part(lws_session, world):
    pytest.skip("Cannot upload a multipart part without an active upload ID in lws")
