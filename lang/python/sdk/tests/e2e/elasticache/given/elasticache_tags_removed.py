"""Given: tags are removed from an "elasticache" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('tags are removed from an "elasticache" "resource"')
def elasticache_tags_removed():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
