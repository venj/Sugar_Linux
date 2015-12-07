Sugar Linux
===========

Platform independent codes copied from [Sugar](https://github.com/venj/Sugar).

Build
-----

```
swift build
```

Usage
-----

Add dependency code in your Package.swift:

```
dependencies: [
    .Package(url: "https://github.com/venj/Sugar_Linux.git", versions: "0.0.1" ..< Version.max),
]
```

Now, in your code:

```
import Sugar
```

See [main.swift](https://github.com/venj/SugarTest/blob/master/Sources/main.swift) for an example.

Note
----

This is a test for how Swift package manager works on Linux platform. Do no use in real project. 

Anyway, I will make [Sugar](https://github.com/venj/Sugar) project cross-platform is possible in future. 
