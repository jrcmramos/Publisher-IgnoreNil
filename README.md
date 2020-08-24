# Description

Extension to `Publisher` with optional output associated type. Ignores `nil` values from the stream.

# Usage

```Swift
var optionalValueSubject: CurrentValueSubject<String?, Never> = CurrentValueSubject("value 1")

let cancellable = optionalValueSubject
    .ignoreNil()
    .sink { print("Received value \($0)") }

optionalValueSubject.value = nil
optionalValueSubject.value = "value 2"

// OUTPUT
Received value value 1
Received value value 2
```