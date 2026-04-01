"""When: LookupEvents is called with AttributeKey ResourceType and AttributeValue AWS::S3::Bucket"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called with AttributeKey ResourceType and AttributeValue AWS::S3::Bucket")
def lookup_events_is_called_with_resource_type_s3_bucket(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[{"AttributeKey": "ResourceType", "AttributeValue": "AWS::S3::Bucket"}]
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
