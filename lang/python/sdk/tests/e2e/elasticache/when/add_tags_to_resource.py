"""When: tags are added to an "elasticache" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('tags are added to an "elasticache" "resource"')
def add_tags_to_resource(lws_session, world):
    pytest.skip("Cannot construct ElastiCache ARN for tag operations in this context")
