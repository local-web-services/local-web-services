"""When: a "glacier" "archive" retrieval job is initiated"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "glacier" "archive" retrieval job is initiated')
def initiate_archive_retrieval(lws_session, world):
    pytest.skip("Cannot initiate archive retrieval job without archive ID in lws")
