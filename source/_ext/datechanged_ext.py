"""
Slight modification of the .. versionchanged:: directive that prints "changed
on" rather than "changed in version".
"""

from sphinx.domains import changeset
from sphinx.locale import _

changeset.versionlabels['datechanged'] = _("Changed on %s")
changeset.versionlabel_classes['datechanged'] = 'changed'

def setup(app):
    app.add_directive('datechanged', changeset.VersionChange)
    return {
        'version': 'builtin',
        'env_version': 1,
        'parallel_read_safe': True,
        'parallel_write_safe': True,
    }
