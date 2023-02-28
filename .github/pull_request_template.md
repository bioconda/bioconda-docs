By default, only 10 recipe pages will be built when not on the `main` branch.
This saves lots of time building. If you want to create *all* (thousands) of
recipe pages, then include the string `[build all recipes]` to the commit that
you want to test.

The built documentation can be found as an artifact pushed after each successful build.
