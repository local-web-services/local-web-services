package io.localwebservices.lws.providers.sns;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** In-memory SNS state storage. */
public class SnsStore {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  public final Map<String, Map<String, Object>> topics = new ConcurrentHashMap<>();
  public final Map<String, Map<String, Object>> subscriptions = new ConcurrentHashMap<>();
  public final Map<String, Map<String, String>> subscriptionAttrs = new ConcurrentHashMap<>();
  public final Map<String, List<Map<String, String>>> resourceTags = new ConcurrentHashMap<>();

  public String topicArn(String name) {
    return "arn:aws:sns:" + REGION + ":" + ACCOUNT + ":" + name;
  }

  public void reset() {
    topics.clear();
    subscriptions.clear();
    subscriptionAttrs.clear();
    resourceTags.clear();
  }
}
