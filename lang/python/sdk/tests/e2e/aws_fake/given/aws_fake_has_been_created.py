"""Given: an "AWS" fake has been created for a service"""

from __future__ import annotations

from pytest_bdd import given

from ..client import AwsFakeTestClient


@given('an "AWS" fake has been created for a service')
def aws_fake_has_been_created(lws_session):
    AwsFakeTestClient(lws_session).create()
