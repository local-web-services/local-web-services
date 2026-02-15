"""Tests for template_parser extract_event_source_mappings."""

from __future__ import annotations

from lws.parser.template_parser import (
    CfnResource,
    extract_event_source_mappings,
)


class TestExtractEventSourceMappings:
    """Extract event source mappings from CloudFormation resources."""

    def test_extracts_sqs_mapping(self) -> None:
        # Arrange
        resources = [
            CfnResource(
                logical_id="MySqsMapping",
                resource_type="AWS::Lambda::EventSourceMapping",
                properties={
                    "FunctionName": "MyFunction",
                    "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:my-queue",
                    "BatchSize": 5,
                },
            ),
        ]

        # Act
        result = extract_event_source_mappings(resources)

        # Assert
        expected_count = 1
        actual_count = len(result)
        assert actual_count == expected_count
        expected_function = "MyFunction"
        actual_function = result[0].function_name
        assert actual_function == expected_function
        expected_batch = 5
        actual_batch = result[0].batch_size
        assert actual_batch == expected_batch

    def test_skips_non_mapping_resources(self) -> None:
        # Arrange
        resources = [
            CfnResource(
                logical_id="MyTable",
                resource_type="AWS::DynamoDB::Table",
                properties={"TableName": "test"},
            ),
        ]

        # Act
        result = extract_event_source_mappings(resources)

        # Assert
        expected_count = 0
        actual_count = len(result)
        assert actual_count == expected_count

    def test_defaults_batch_size_and_enabled(self) -> None:
        # Arrange
        resources = [
            CfnResource(
                logical_id="MinimalMapping",
                resource_type="AWS::Lambda::EventSourceMapping",
                properties={
                    "FunctionName": "Func",
                    "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:q",
                },
            ),
        ]

        # Act
        result = extract_event_source_mappings(resources)

        # Assert
        expected_batch = 10
        actual_batch = result[0].batch_size
        assert actual_batch == expected_batch
        assert result[0].enabled is True
