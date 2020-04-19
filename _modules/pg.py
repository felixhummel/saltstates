#!/usr/bin/env python
# vim: set fileencoding=utf-8 filetype=python :
"""
Simple wrapper for pg_dump and pg_restore.

http://www.postgresql.org/docs/9.4/static/app-pgrestore.html
"""
from __future__ import unicode_literals

from datetime import datetime
import logging
log = logging.getLogger(__name__)
import os.path

from salt.exceptions import CommandExecutionError

FORMAT = 'custom'
DATE_FORMAT = '%Y-%m-%d_%H-%M-%S'
FILE_REGEX = r'\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}.*\.pg'


def get_backup_dir(dbname):
    return '/var/backups/{0}'.format(dbname)


def dump(dbname, name='', repo=None, runas='postgres', umask='007'):
    """
    :param dbname: Name of the database.
    :param name: Optional human-readable, but *unix-path-safe*, name for the
                 dump. Gets appended to the automatically generated file name.
    :param repo: Optional path to a git repository. If this is given then
                 this repo's shortrev of HEAD will be included in the
                 filename.
    :param runas: pg_dump is run as this user. See also cmd.retcode.
    :param umask: pg_dump is run with this umask. See also cmd.retcode.
    """
    # generate filename
    backup_dir = get_backup_dir(dbname)
    dtstring = datetime.now().strftime(DATE_FORMAT)
    sep = '__'
    parts = [dtstring]
    if repo is not None:
        shortrev = __salt__['git.revision'](repo, short=True)
        parts.append(shortrev)
    if name:
        parts.append(name)
    filename = sep.join(parts) + '.pg'
    abspath = os.path.join(backup_dir, filename)
    # do the actual work
    cmd = [
        'pg_dump',
        '--verbose',
        '--format', FORMAT,
        '--file', abspath,
        dbname
    ]
    retcode = __salt__['cmd.retcode'](cmd, cwd='/', runas=runas, umask=umask)
    if retcode != 0:
        raise CommandExecutionError('Could not execute %s' % cmd)
    return abspath


def latest(dbname):
    """
    Returns path to latest dump.

    .. note:: This assumes that the backup dir contains only files generated
              by this command.

    :param dbname: Name of the database.
    """
    backup_dir = get_backup_dir(dbname)
    if not __salt__['file.directory_exists'](backup_dir):
        raise CommandExecutionError(
            'Backup dir does not exist: {0}'.format(backup_dir)
        )
    candidates = __salt__['file.find'](backup_dir, regex=FILE_REGEX)
    if not candidates:
        msg = 'No backups found in "{0}"'
        raise CommandExecutionError(msg.format(backup_dir))
    filename = reversed(sorted(candidates)).next()
    path = os.path.join(backup_dir, filename)
    return path


def restore(path, verbose=False, runas='postgres'):
    """
    :param path: Dump file to load. Use get_latest to get a path to the
                 latest dump.
    :param runas: pg_dump is run as this user. See also cmd.retcode.
    """
    cmd = ['pg_restore']
    if verbose:
        cmd.append('--verbose')
    cmd.extend([
        '--format', FORMAT,
        '--dbname', 'postgres',  # connect to this DB to issue the create
        '--clean',
        '--create',
        path
    ])
    return __salt__['cmd.run'](cmd, cwd='/', runas=runas)
