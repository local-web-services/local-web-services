"""When: a multipart upload is initiated for a vault"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a multipart upload is initiated for a vault")
def initiate_multipart_upload(lws_session, world):
    pytest.skip("Multipart upload is not supported by the lws glacier provider")
