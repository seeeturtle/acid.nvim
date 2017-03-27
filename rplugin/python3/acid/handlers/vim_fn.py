from acid.handlers import BaseHandler


class Handler(BaseHandler):

    name = "VimFn"
    priority = 0

    def on_init(self):
        self.vim_fn = ""

    def configure(self, vim_fn, *args, **kwargs):
        super().configure(*args, **kwargs)
        self.vim_fn = vim_fn
        return self

    def on_handle(self, msg, *_):
        if self.vim_fn:
            self.nvim.call(self.vim_fn, msg)
