package io.localwebservices.lws;

import static io.cucumber.junit.platform.engine.Constants.*;

import org.junit.platform.suite.api.*;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@SelectClasspathResource("sns_sqs")
@SelectClasspathResource("events_sqs")
@SelectClasspathResource("events_sns")
@SelectClasspathResource("s3api_sns")
@SelectClasspathResource("s3api_sqs")
@SelectClasspathResource("stepfunctions_sqs")
@SelectClasspathResource("stepfunctions_dynamodb")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "io.localwebservices.lws.steps")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "progress")
@ConfigurationParameter(
    key = FILTER_TAGS_PROPERTY_NAME,
    value = "(@minimal or @standard) and not @internal")
public class CucumberRunnerTest {}
