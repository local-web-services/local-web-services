"""When: a "GET" request is received and the "API" retrieves an existing object from S3"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "GET" request is received and the "API" retrieves an existing object from S3')
def get_request_retrieves_object(world):
    pytest.skip("Cannot simulate S3 GetObject via API Gateway in lws without pre-seeded object")
