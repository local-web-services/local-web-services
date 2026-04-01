"""Given: tags are added to an "elasticache" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('tags are added to an "elasticache" "resource"')
def elasticache_tags_added():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
