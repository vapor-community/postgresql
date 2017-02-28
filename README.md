# PostgreSQL for Swift

[![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)](https://swift.org)
[![Build Status](https://travis-ci.org/vapor/postgresql.svg?branch=master)](https://travis-ci.org/vapor/postgresql)

A Swift wrapper for PostgreSQL.

- [x] Thread-Safe
- [x] Prepared Statements
- [x] Tested

This wrapper uses the latest PostgreSQL fetch API to enable performant prepared statements and output bindings. Data is sent to and received from the PostgreSQL server in its native data type without converting to and from strings.

The Swift wrappers around the PostgreSQL's C structs and pointers automatically manage closing connections and deallocating memory. Additionally, the PostgreSQL library API is used to perform thread safe, performant queries to the database.

## 📖 Examples

### Connecting to the Database

```swift
import PostgreSQL

let postgreSQL =  PostgreSQL.Database(
    dbname: "test",
    user: "root",
    password: ""
)
```

### Select

```swift
let version = try postgreSQL.execute("SELECT version()")
```

### Prepared Statement

The second parameter to `execute()` is an array of `PostgreSQL.Value`s.

```swift
let results = try postgreSQL.execute("SELECT * FROM users WHERE age >= $1", [.int(21)])
```

```swift
public enum Value {
    case string(String)
    case int(Int)
    case bool(Int)
    case double(Double)
    case null
}
```

### Listen and Notify

```swift
try postgreSQL.listen(to: "test_channel") { notification in
    print(notification.channel)
    print(notification.payload)
}

// Allow set up time for LISTEN
sleep(1)

try postgreSQL.notify(channel: "test_channel", payload: "test_payload")

```

### Connection

Each call to `execute()` creates a new connection to the PostgreSQL database. This ensures thread safety since a single connection cannot be used on more than one thread.

If you would like to re-use a connection between calls to execute, create a reusable connection and pass it as the third parameter to `execute()`.

```swift
let connection = try postgreSQL.makeConnection()
let result = try postgreSQL.execute("SELECT LAST_INSERTED_ID() as id", [], connection)
```

No need to worry about closing the connection.

## 🚀 Building

### macOS

Install PostgreSQL

```shell
brew install postgresql
brew link postgresql
brew services start postgresql
```

### Linux

Install PostgreSQL

```shell
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib libpq-dev
psql -h dbhost -U username dbname
```

Use `vapor build` or `swift build`.

## Fluent

This wrapper was created to power [Fluent](https://github.com/qutheory/fluent), an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) for Swift.

## 👥 Contributors

Maintained by [Steven Roebert](https://github.com/sroebert), [Nate Bird](https://twitter.com/natesbird), [Prince Ugwuh](https://twitter.com/Prince2k3), and other members of the Vapor community.
