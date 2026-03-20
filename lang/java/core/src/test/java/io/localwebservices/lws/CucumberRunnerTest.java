package io.localwebservices.lws;

import static io.cucumber.junit.platform.engine.Constants.*;

import org.junit.platform.suite.api.*;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("informal/dynamodb")
@SelectClasspathResource("informal/sqs")
@SelectClasspathResource("informal/s3api")
@SelectClasspathResource("informal/sns")
@SelectClasspathResource("informal/events")
@SelectClasspathResource("informal/stepfunctions")
@SelectClasspathResource("informal/ssm")
@SelectClasspathResource("informal/secretsmanager")
@SelectClasspathResource("informal/events_dynamodb")
@SelectClasspathResource("informal/events_sns")
@SelectClasspathResource("informal/events_sqs")
@SelectClasspathResource("informal/events_stepfunctions")
@SelectClasspathResource("informal/s3api_events")
@SelectClasspathResource("informal/s3api_sns")
@SelectClasspathResource("informal/s3api_sqs")
@SelectClasspathResource("informal/secretsmanager_events")
@SelectClasspathResource("informal/sns_sqs")
@SelectClasspathResource("informal/ssm_events")
@SelectClasspathResource("informal/stepfunctions_dynamodb")
@SelectClasspathResource("informal/stepfunctions_events")
@SelectClasspathResource("informal/stepfunctions_s3api")
@SelectClasspathResource("informal/stepfunctions_secretsmanager")
@SelectClasspathResource("informal/stepfunctions_sns")
@SelectClasspathResource("informal/stepfunctions_sqs")
@SelectClasspathResource("informal/stepfunctions_ssm")
@SelectClasspathResource("informal/organizations")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "io.localwebservices.lws.steps")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "progress")
@ConfigurationParameter(
    key = FILTER_TAGS_PROPERTY_NAME,
    value = "(@minimal or @standard)")
public class CucumberRunnerTest {}
