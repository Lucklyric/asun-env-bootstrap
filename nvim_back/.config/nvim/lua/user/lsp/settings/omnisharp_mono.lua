return {
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
}
