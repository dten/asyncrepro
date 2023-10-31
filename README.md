# asyncrepro

run netcat in one shell

```bash
nc -l 3070
```

then in another shell

```bash
stack run asyncrepro-exe
```

you should get the following output

```
asyncrepro-exe: internal error: ASSERTION FAILED: file rts/Schedule.h, line 175

    (GHC version 9.4.7 for x86_64_unknown_linux)
    Please report this as a GHC bug:  https://www.haskell.org/ghc/reportabug
Aborted
```
