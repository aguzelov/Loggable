# Loggable

A tiny Swift Package that adds `os.Logger`-based logging to any type via a single protocol conformance.

## Requirements

- iOS 16+ / macOS 11+
- Swift 5.8+

## Usage

Conform any type to `Loggable` — no methods to implement, everything comes from a protocol extension:

```swift
import Loggable

struct UserService: Loggable {
    func fetchProfile() {
        logInfo("Fetching profile", subsystem: "com.example.app")
    }
}
```

Each conforming type gets its own logger, categorized by its type name, plus one method per level:

- `logDebug`
- `logInfo`
- `logError`
- `logFault`
- `logWarning`

All of them (and the underlying `log(level:_:subsystem:privacy:function:line:)`) accept:

- `subsystem` — required, identifies the logging subsystem (e.g. your bundle identifier).
- `privacy` — defaults to `.private`. Only pass `.public` for values you've verified contain no PII, tokens, or other sensitive data; the library does not scrub or mask message content on your behalf.
- `function` / `line` — captured automatically via `#function`/`#line`, no need to pass them.

Each log line is emitted with a level-specific emoji prefix (`ℹ️`/`❌`/`💥`/`⚠️`) plus the caller's type, line, and function for quick scanning in Console.
