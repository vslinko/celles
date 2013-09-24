# celles

> Small FRP library.

## Usage

```coffee
celles = require "celles"

a = celles.cell 1
b = celles.cell 2

console.log a.value # 1
console.log b.value # 2

c = celles.formula [a, b], (a, b) ->
  a + b

console.log c.value # 3

a.set 2

console.log c.value # 4

d = celles.template
  propA: a
  propB: b
  propC: c

console.log d.value # { propA: 2, propB: 2, propC: 4 }

b.set 3

console.log d.value # { propA: 2, propB: 3, propC: 5 }
```

## Schedule

* 0.2 - recursive template
* 0.3 - integration with callbacks and promises
* 0.4 - integration with streams
