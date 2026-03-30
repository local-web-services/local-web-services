package io.localwebservices.lws.providers.dynamodb;

import java.util.*;

/** Represents a single DynamoDB table definition with its stored items. */
public class TableDef {

  public final String name;
  public final String pkName;
  public final String pkType;
  public final String skName;
  public final String skType;
  public final List<Map<String, Object>> gsis;
  public final Map<String, Map<String, Object>> items = new LinkedHashMap<>();
  public final long createdAt = System.currentTimeMillis();

  // Stream metadata
  public boolean streamEnabled = false;
  public String streamViewType = null;
  public String latestStreamArn = null;

  public TableDef(
      String name,
      String pkName,
      String pkType,
      String skName,
      String skType,
      List<Map<String, Object>> gsis) {
    this.name = name;
    this.pkName = pkName;
    this.pkType = pkType;
    this.skName = skName;
    this.skType = skType;
    this.gsis = gsis != null ? gsis : new ArrayList<>();
  }
}
