# Bioconda documentation

This repository stores the source code for the bioconda docs at
https://bioconda.github.io. When pull requests are merged in to the main
branch, the docs are built and pushed to the [bioconda.github.io
repo](https://github.com/bioconda/bioconda.github.io) for public hosting.

Note that prior to 2023-02-28, this documentation source was in the
[bioconda-utils](https://github.com/bioconda/bioconda-utils) repo, but has been
split out for simplicity.

## Notes on pull requests

When a pull request is submitted for a branch, and on every subsequent push to
the branch, the documentation will be built and uploaded as an artifact to the
job. This is a file, `doc.zip`, that can be found on the GitHub Actions page for
that job. This is a convenient way of checking formatting issues in the built
documentation, without requiring a full local setup.

When submitting a pull request, by default only 10 recipes' pages will be built.
This dramatically speeds up the build process (by >10x) for faster iteration
times.

**If you need to build all recipe README.html pages,** for some reason, you can
include the text `[build all recipes]` in the commit message of the commit you
want to build everything for.

## Building docs locally

You'll need to make an environment, which includes bioconda-utils as well as
Sphinx and everything else you need:

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

