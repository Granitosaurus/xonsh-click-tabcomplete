import pip as _pip
_ALL_PACKAGES = [(p.key, ','.join(req.name for req in p.requires())) for p in _pip.get_installed_distributions()]
_CLICK_PACKAGES = [p[0] for p in _ALL_PACKAGES if 'click' in p[1].split(',')]
del _ALL_PACKAGES
_cache = dict()
del _pip


def _get_help(commands):
    """
    retrieves commands and flags of "click" based command
    """
    import re
    import subprocess
    if not _cache.get(commands):
        try:
            help_text = subprocess.check_output(commands.split() + ['--help']).decode()
            commands = re.findall('\n  (\w+)', help_text.split('Commands:')[-1]) if 'Commands:' in help_text else []
            flags = re.findall('\n.+(--.+?) ', help_text.split('Options:')[-1]) if 'Options:' in help_text else []
        except Exception:
            return []
        _cache[commands] = commands, flags
    return _cache[commands]


def _return_commands(items, prefix):
    return [i for i in items if i.startswith(prefix)], len(prefix)


def _click_completer(prefix, line, begidx, endidx, ctx):
    """
    Tab completion for python applications based on "click" command line interface framework.
    """
    # check whether to use this completer
    package = line.split(' ')[0]
    if package not in _CLICK_PACKAGES:
        return

    commands, flags = _get_help(package)
    # when "command " | "command subcom"
    if (len(line.split()) < 2 and not prefix) or (len(line.split()) < 3 and prefix):
        return _return_commands(commands + flags, prefix)
    # when "command subcommand "
    commands, flags = _get_help(' '.join(line.split()[:2]))
    if len(line.split()) > 1:
        return _return_commands(commands + flags, prefix)
    else:
        return _return_commands(flags, prefix)


# add to list of completers
__xonsh_completers__['click'] = _click_completer
# bump to top of list (otherwise bash completion interferes)
__xonsh_completers__.move_to_end('click', last=False)
