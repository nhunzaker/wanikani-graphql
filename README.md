# WaniKani GraphQL

This repo provides a crude GraphQL interface over the WaniKani API. When possible, it batches requests to mitigate API usage.

## Setup Instructions

```
cp ./config/dev.exs.example ./config/dev.exs
# update config/dev.exs with your API Version 2 token
iex -S mix
```

You can visit the GraphiQL explorer at `http://localhost:4000/graphiql`.

## What's missing (todo)

- [ ] Pagination on subjects
- [ ] Additional endpoint query parameters
- [ ] A handful of subresources
- [ ] Union between subjects (Radical, Kanji, Vocab)
- [ ] Caching
