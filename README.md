# Bioconda documentation

**main docs: https://bioconda.github.io**

This repository stores the source code for the bioconda docs at
https://bioconda.github.io.

When pull requests in this repo are merged into the `main` branch, the docs are
built and pushed to the [bioconda.github.io
repo](https://github.com/bioconda/bioconda.github.io) for public hosting.

Note that prior to 2023-02-28, this documentation source was in the
[bioconda-utils](https://github.com/bioconda/bioconda-utils) repo, but has been
split out for simplicity and ease of maintenance.

Why keep this separate from the from bioconda.github.io where the built docs
live? Because this source code is relatively small, but the built docs are
rather large. If we worked on the source over in bioconda.github.io, even if
the source lived on a different branch, every time it was cloned we would be
pulling full git history (including the large built docs). This separate repo
allows us to keep editing the documentation lightweight.

## Notes on pull requests

- Inspect the built docs for each job. When a pull request is submitted for
  a branch, and on every subsequent push to the branch, the documentation will
  be built and uploaded as an artifact to the job. This is a file, `doc.zip`,
  that can be found on the GitHub Actions page for that job. This is
  a convenient way of checking formatting issues in the built documentation,
  without requiring a full local setup.

- By default, only 10 recipes' README.html pages will be built. This
  dramatically speeds up the build process (by >10x) for faster iteration
  times. **If you need to build all recipe README.html pages** for some
  reason, you can include the text `[build all recipes]` in the commit message
  of the commit you want to build everything for.

## Building docs locally

Make an environment containing the `bioconda-utils` package. E.g.,

```bash
mamba create \
  env -n bioconda-docs \
  bioconda-utils \
  --channel conda-forge \
  --channel bioconda \
  --strict-channel-priority
```

With that environment activated (i.e., `conda activate bioconda-docs`), in the
top level of this repo, run:

```bash
make BIOCONDA_FILTER_RECIPES=10 html SPHINXOPTS="-T -j1"
```

The output will be found in `build/html`. 

Note that you can set `BIOCONDA_FILTER_RECIPES` to some other number; omitting
it completely will build *all* recipes' README.html pages which can take
a while.


## Points of interest

- Docs are built with Sphinx
- the `source/_ext` directory has Sphinx extensions for building the recipe
  README html files (along with making backlinks for dependencies' READMEs) and
  for a `.. details::` directive.

## Update frequency

These docs are automatically built each day, after pulling the latest changes
to bioconda-recipes. This means that newly-added recipes or recently-updated
recipes will not show up in the package index for a day or so.