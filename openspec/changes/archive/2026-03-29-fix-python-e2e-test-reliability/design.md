# Design: Fix Python e2e test suite reliability

## Context

The `cluster_db_service` shared factory was built for DocumentDB and Neptune management-plane operations (create/describe/delete cluster and instance). It uses `parse_json_body` to read requests and `json_response` to write responses. However Neptune (and the related RDS and DocumentDB) use the AWS **query protocol**: requests arrive as `application/x-www-form-urlencoded` with an `Action=` key; responses are expected to be XML. boto3 raises `ResponseParserError` whenever it receives JSON instead of XML from a query-protocol service.

## Goals / Non-Goals

- **Goals**: Make all Neptune management-plane e2e tests pass. Add the EventBridge `delete_rule` target guard. Fix the three narrow implementation bugs in EventBridge put_targets e2e setup, Glacier step definitions, and StepFunctions/SSM world state.
- **Non-Goals**: Implement Neptune graph query operations (openCypher / Gremlin) — those are tracked under `add-python-rds-query-protocol`. Make RDS or DocumentDB management-plane operations XML-correct in this change (they share the factory and will benefit automatically, but their e2e suites are not targeted here).

## Decisions

### Neptune XML protocol

**Decision**: Add a boolean `use_query_protocol: bool = False` field to `ClusterDBConfig`. When `True`, the factory:
1. Parses the request body as `application/x-www-form-urlencoded` (using Python's `urllib.parse.parse_qs`) instead of JSON.
2. Extracts `Action` from the form data instead of the JSON body.
3. Wraps all responses in the standard AWS query-protocol XML envelope (`<ActionResponse><ActionResult>…</ActionResult><ResponseMetadata>…</ResponseMetadata></ActionResponse>`).
4. Sets `Content-Type: text/xml` on every response.

Neptune's `_NEPTUNE_CONFIG` gets `use_query_protocol=True`. DocumentDB and RDS should also be set to `True` in the same PR to prevent identical failures there.

**Alternatives considered**:
- Per-handler XML serialisation: more flexible, but requires touching every handler in the factory (high churn).
- A separate Neptune-specific factory: avoids conditionals in the shared factory but duplicates 300+ lines of logic.

The config flag is the minimal change: one parsing branch and one serialisation branch added to the factory.

### XML response envelope

AWS query-protocol responses wrap the service-specific payload in:
```xml
<DescribeDBClustersResponse xmlns="http://rds.amazonaws.com/doc/2014-10-31/">
  <DescribeDBClustersResult>
    <DBClusters>…</DBClusters>
  </DescribeDBClustersResult>
  <ResponseMetadata>
    <RequestId>…</RequestId>
  </ResponseMetadata>
</DescribeDBClustersResponse>
```

The root element name is `{Action}Response`; the result wrapper is `{Action}Result`. A helper `xml_response(action, payload_dict)` will build this from the existing JSON payload dict using Python's `xml.etree.ElementTree`.

**Alternatives considered**: Third-party XML serialisers (`lxml`, `xmltodict`). Rejected — stdlib `ElementTree` is sufficient for the flat dict payloads these handlers return, and adds no dependency.

### EventBridge `delete_rule` guard

`EventBridgeProvider.delete_rule` must call `list_targets_by_rule` and return a `ValidationException` (HTTP 400) if any targets remain. This mirrors the real AWS behavior and unblocks the existing scenario.

## Risks / Trade-offs

- The XML envelope structure must exactly match what boto3 expects per its service model. A mismatch in element naming will produce a different parse error. Validate with an actual `RebootDBInstance` call during implementation.
- Setting `use_query_protocol=True` for RDS and DocumentDB may expose additional failing tests for those services (they share the factory). This is acceptable — their failures are currently masked by skip markers. Address any new failures as follow-on bug fixes.

## Open Questions

- None blocking implementation.
