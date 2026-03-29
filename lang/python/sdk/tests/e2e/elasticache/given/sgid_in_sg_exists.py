"""Given: sgid in sg_exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("sgid in sg_exists")
def sgid_in_sg_exists(lws_session):
    ElasticacheTestClient(lws_session).create_subnet_group()
