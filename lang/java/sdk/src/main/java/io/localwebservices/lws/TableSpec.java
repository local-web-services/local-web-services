package io.localwebservices.lws;

/** Describes a DynamoDB table to create in the local session. */
public class TableSpec {

    private final String name;
    private final String partitionKey;
    private String sortKey;

    public TableSpec(String name, String partitionKey) {
        this.name = name;
        this.partitionKey = partitionKey;
    }

    public TableSpec sortKey(String sortKey) { this.sortKey = sortKey; return this; }

    public String getName() { return name; }
    public String getPartitionKey() { return partitionKey; }
    public String getSortKey() { return sortKey; }
}
