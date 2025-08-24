return {
  'jakewvincent/mkdnflow.nvim',
  ft = 'markdown',
  config = function()
    require('mkdnflow').setup({
      -- Config goes here; leave blank for defaults
    })
  end
}
