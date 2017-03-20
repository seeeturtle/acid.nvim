from acid.commands import BaseCommand
from acid.nvim import get_acid_ns, find_clojure_fn
import os


class Command(BaseCommand):

    name = 'AddRequire'
    priority = 0
    cmd_name = 'AcidAddRequire'
    handlers = ['MetaRepl']
    mapping = 'cdr'
    prompt = 1
    nargs = "*"
    op = "eval"

    def prepare_payload(self, *args):
        require = " ".join(args)
        self.nvim.command('command "normal! ?:require\<CR>\"sa)"')
        data = "(add-req '{} '{})".format(self.nvim.funcs.getreg("s"), require)

        return {'code': data,
                'ns': 'clojure-vim.acid.nvim.fns'}