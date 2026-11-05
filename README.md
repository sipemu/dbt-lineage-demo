# dbt-lineage demo

A small jaffle-shop-style dbt project that shows the [dbt-lineage](https://github.com/sipemu/dbt-lineage-viewer) GitHub Action on pull requests.

**See it in action:** open [pull requests](../../pulls?q=is%3Apr) — each one gets a sticky comment with:

- the lineage diff against the target branch (added, modified, removed models, including SQL body changes),
- a Mermaid diagram of the changed models and everything downstream of them,
- the minimal rebuild selector (`dbt build -s "…"`),
- lint findings, also annotated inline on the changed files via SARIF.

No warehouse, no Python and no `dbt compile` needed; the action parses the SQL directly.

## Dashboards as exposures

[`dashboards/`](dashboards/) holds two [anofox-visualization](https://github.com/DataZooDE/anofox-visualization) dashboards (plain DuckDB SQL). The [Exposures workflow](.github/workflows/exposures.yml) runs `dbt-lineage exposures anofox` on every change and commits [`models/exposures_dashboards.yml`](models/exposures_dashboards.yml), so a PR that touches `orders`, `customers` or `stg_payments` shows which dashboards it reaches, and the [lineage site](https://sipemu.github.io/dbt-lineage-demo/) draws them. Metabase, Tableau, Looker, Superset and Power BI work the same way (`dbt-lineage exposures <tool>`).

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
      - uses: actions/checkout@v5
        with: { fetch-depth: 0 }
      - uses: sipemu/dbt-lineage-viewer@v0
        with:
          sarif: lint,coverage
```

The full workflow is in [`.github/workflows/dbt-lineage.yml`](.github/workflows/dbt-lineage.yml).
