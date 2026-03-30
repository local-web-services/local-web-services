"""Given: the instance belongs to this cluster"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("the instance belongs to this cluster")
def instance_belongs_to_cluster(lws_session):
    DocdbTestClient(lws_session).create_instance()
