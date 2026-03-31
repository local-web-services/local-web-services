"""When: tags are removed from an "elasticache" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('tags are removed from an "elasticache" "resource"')
def remove_tags_from_resource(lws_session, world):
    pytest.skip("Cannot construct ElastiCache ARN for tag operations in this context")
