package io.localwebservices.lws;

import org.junit.platform.suite.api.*;

import static io.cucumber.junit.platform.engine.Constants.*;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "io.localwebservices.lws.steps")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "progress")
public class CucumberRunnerTest {
}
