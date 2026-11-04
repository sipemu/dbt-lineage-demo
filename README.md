# dbt-lineage demo

A small jaffle-shop-style dbt project that shows the [dbt-lineage](https://github.com/sipemu/dbt-lineage-viewer) GitHub Action on pull requests.

**See it in action:** open [pull requests](../../pulls?q=is%3Apr) — each one gets a sticky comment with:

- the lineage diff against the target branch (added, modified, removed models, including SQL body changes),
- a Mermaid diagram of the changed models and everything downstream of them,
- the minimal rebuild selector (`dbt build -s "…"`),
- lint findings, also annotated inline on the changed files via SARIF.

No warehouse, no Python and no `dbt compile` needed; the action parses the SQL directly.

## Use it in your repo

```yaml
# .github/workflows/dbt-lineage.yml
on: pull_request
permissions:
  contents: read
  pull-requests: write
  security-events: write
jobs:
  lineage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - uses: sipemu/dbt-lineage-viewer@v0
        with:
          sarif: lint,coverage
```

The full workflow is in [`.github/workflows/dbt-lineage.yml`](.github/workflows/dbt-lineage.yml).
