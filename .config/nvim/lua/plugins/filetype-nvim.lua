require("filetype").setup({
  overrides = {
    function_extensions = {
      ["pl"] = function()
        vim.bo.filetype = "prolog"
      end
    }
  }
})
