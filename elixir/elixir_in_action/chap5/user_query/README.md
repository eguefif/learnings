# UserQuery

## Exercise: Parallel user lookup

You have a list of user IDs. For each one, spawn a process that simulates a database query (use `Process.sleep` to fake latency), then collect all results back in the main process.

### Requirements

- Spawn one process per ID
- Each process sends its result back to the caller
- The main process collects all results before printing them
- Print the list of results at the end

### Expected output

Order may vary since processes finish at different times:

```
[{:ok, 3, "User_3"}, {:ok, 1, "User_1"}, {:ok, 5, "User_5"}, ...]
```

### Hints

- `self()` inside a spawned process won't give you the parent pid — capture it before `spawn`
- You need to call `receive` N times to collect N messages
- Spawn all processes first, then collect — don't interleave spawn and collect

### Run

```
mix user_query
```

